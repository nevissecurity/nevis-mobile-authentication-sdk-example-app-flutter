// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_verification_data.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticators_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/biometric_listen_for_os_credentials_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_parameter.dart';

@singleton
class AppBloc extends Bloc<AppEvent, AppState> {
  final FingerPrintListenForOsCredentialsUseCase
      _fingerPrintListenForOsCredentialsUseCase;
  final BiometricListenForOsCredentialsUseCase
      _biometricListenForOsCredentialsUseCase;
  final AuthenticatorsUseCase _authenticatorsUseCase;
  final DeregisterUseCase _deregisterUseCase;
  final ConfigurationLoader _configurationLoader;
  final ErrorHandler _errorHandler;
  final DomainBloc _domainBloc;
  final GlobalNavigationManager _globalNavigationManager;
  late StreamSubscription _domainSubscription;

  AppBloc(
    this._fingerPrintListenForOsCredentialsUseCase,
    this._biometricListenForOsCredentialsUseCase,
    this._authenticatorsUseCase,
    this._deregisterUseCase,
    this._configurationLoader,
    this._errorHandler,
    this._domainBloc,
    this._globalNavigationManager,
  ) : super(InitialState()) {
    _domainSubscription = _domainBloc.stream.listen((DomainState state) {
      add(AppDomainEvent(state));
    });
    on<AppDomainEvent>(_handleDomainEvent);
    on<UserBiometricEvent>(_handleUserBiometricEvent);
    on<UserFingerPrintEvent>(_handleUserFingerPrintEvent);
    on<UserPinEvent>(_handleUserPinEvent);
  }

  void _handleDomainEvent(
    AppDomainEvent event,
    Emitter<AppState> emit,
  ) {
    final state = event.domainState;
    if (state is DomainVerifyState) {
      _handleDomainVerify(state, emit);
    } else if (state is DomainSelectAuthenticatorState) {
      _globalNavigationManager.pushSelectAuthenticator(
        SelectAuthenticatorParameter(
          authenticatorItems: state.authenticatorItems,
          operationType: state.operationType,
        ),
      );
    } else if (state is DomainResultState) {
      _globalNavigationManager
          .pushResult(ResultParameter.success(description: state.description));
    } else if (state is DomainSelectAccountState) {
      _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          operationType: state.operationType,
          accounts: state.accounts,
          transactionConfirmationData: state.transactionConfirmationData,
        ),
      );
    } else if (state is DomainTransactionConfirmationState) {
      _globalNavigationManager.pushTransactionData(
        TransactionConfirmationParameter(
          transactionData: state.transactionData,
          selectedAccount: state.selectedAccount,
        ),
      );
    } else if (state is DomainAuthenticationSucceededState) {
      _handleAuthenticationSucceeded(state);
    }
  }

  void _handleDomainVerify(
    DomainVerifyState state,
    Emitter<AppState> emit,
  ) {
    if (state is DomainPinState && state.mode == PinMode.verification) {
      emit(
        VerifyPinState(
          protectionStatus: state.protectionStatus,
          lastRecoverableError: state.lastRecoverableError,
        ),
      );
    } else if (state is DomainVerifyFingerPrintState) {
      emit(VerifyFingerPrintState());
    } else if (state is DomainVerifyBiometricState) {
      emit(VerifyBiometricState());
    }
  }

  Future<void> _handleUserFingerPrintEvent(
    UserFingerPrintEvent event,
    Emitter<AppState> emit,
  ) async {
    await _fingerPrintListenForOsCredentialsUseCase.execute().then((_) {
      emit(InitialState());
    }).catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleUserBiometricEvent(
    UserBiometricEvent event,
    Emitter<AppState> emit,
  ) async {
    await _biometricListenForOsCredentialsUseCase
        .execute(BiometricPromptOptions(
      title: event.title,
      description: event.description,
      cancelButtonText: event.cancelButtonText,
    ))
        .then((_) {
      emit(InitialState());
    }).catchError((error) {
      _errorHandler.handle(error);
    });
  }

  Future<void> _handleUserPinEvent(
    UserPinEvent event,
    Emitter<AppState> emit,
  ) async {
    _globalNavigationManager.pushPin(
      PinParameter.verification(
        pinVerificationData: PinVerificationData(
          protectionStatus: event.protectionStatus,
          lastRecoverableError: event.lastRecoverableError,
        ),
      ),
    );
  }

  Future<void> _handleAuthenticationSucceeded(
    DomainAuthenticationSucceededState state,
  ) async {
    // based on current backend configuration FIDO UAF authentication is needed for deregistration
    // and dispatch target deletion in the Identity Suite environment.
    // The result of the authentication is handled (username + auth provider) and based on the requested operation type
    // the corresponding use case will be executed.
    final username = state.username;
    AuthorizationProvider? authorizationProvider = state.authorizationProvider;
    if (authorizationProvider is CookieAuthorizationProvider) {
      // if a cookie auth provider is received, we need to fill in the correct uri
      final configuration = await _configurationLoader.load();
      String? path;
      if (state.operationType == OperationType.deregistration) {
        path = configuration.sdkConfiguration.deregistrationRequestPath;
      } else {
        _errorHandler.handle(BusinessException.invalidState());
        return;
      }

      final uri = Uri.parse(configuration.sdkConfiguration.baseUrl + path);
      for (CookieContainer container
          in authorizationProvider.cookieContainers) {
        container.uri = uri;
      }
    }

    if (username == null || authorizationProvider == null) {
      _errorHandler.handle(BusinessException.missingCookie());
      return;
    }

    if (state.operationType == OperationType.deregistration) {
      final authenticators = await _registeredAuthenticators(username);
      await _deregisterUseCase
          .execute(
        username: username,
        authorizationProvider: authorizationProvider,
        authenticators: authenticators,
      )
          .catchError((error) {
        _errorHandler.handle(error);
      });
    } else {
      _errorHandler.handle(BusinessException.invalidState());
    }
  }

  Future<Set<Authenticator>> _registeredAuthenticators(String username) async {
    final authenticators = await _authenticatorsUseCase.execute();
    return authenticators
        .where((element) => element.registration.isRegistered(username))
        .toSet();
  }

  @override
  Future<void> close() {
    _domainSubscription.cancel();
    return super.close();
  }
}
