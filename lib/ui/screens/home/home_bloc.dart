// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/app_environment.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/deep_link_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticators_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_pin_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_all_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_process_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registered_accounts_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DeepLinkRepository _deepLinkRepository;
  final ConfigurationLoader _configurationLoader;
  final ClientProvider _clientProvider;
  final OobProcessUseCase _oobProcessUseCase;
  final RegisteredAccountsUseCase _registeredAccountsUseCase;
  final DeregisterAllUseCase _deregisterAllUseCase;
  final AuthenticatorsUseCase _authenticatorsUseCase;
  final ChangePinUseCase _changePinUseCase;
  final LocalDataBloc _localDataBloc;
  final ErrorHandler _errorHandler;
  final GlobalNavigationManager _globalNavigationManager;
  late StreamSubscription _localDataSubscription;
  late StreamSubscription _deepLinkRepositorySubscription;

  Set<Account> _registeredAccounts = {};
  Set<Authenticator> _authenticators = {};

  HomeBloc(
    this._deepLinkRepository,
    this._configurationLoader,
    this._clientProvider,
    this._oobProcessUseCase,
    this._registeredAccountsUseCase,
    this._deregisterAllUseCase,
    this._authenticatorsUseCase,
    this._changePinUseCase,
    this._localDataBloc,
    this._errorHandler,
    this._globalNavigationManager,
  ) : super(HomeInitialState()) {
    // Checking broadcast stream, if deep link was clicked in opened application
    _deepLinkRepositorySubscription =
        _deepLinkRepository.setDeepLinkReceiver((redirectUri) {
      add(OOBRedirectArrivedEvent(redirectUri));
    });
    _localDataSubscription =
        _localDataBloc.stream.listen((LocalDataState state) {
      add(LocalDataEvent(state));
    });
    on<HomeCreatedEvent>(_handleHomeCreated);
    on<ClientInitializedEvent>(_handleClientInitialized);
    on<OOBRedirectArrivedEvent>(_handleOOBRedirect);
    on<ReadQrCodeEvent>(_handleReadQrCode);
    on<DeregisterEvent>(_handleDeregister);
    on<InBandAuthenticationEvent>(_handleInBandAuthentication);
    on<InBandRegisterEvent>(_handleInBandRegister);
    on<PinChangeEvent>(_handlePinChange);
    on<ChangeDeviceInformationEvent>(_handleChangeDeviceInformation);
    on<AuthCloudApiRegistrationEvent>(_handleAuthCloudApiRegistration);
    on<LocalDataEvent>(_handleLocalData);
  }

  Future<void> _handleHomeCreated(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _initClient(emit);
  }

  Future<void> _handleClientInitialized(
    ClientInitializedEvent event,
    Emitter<HomeState> emit,
  ) async {
    //Checking application start by deep link
    final uri = await _deepLinkRepository.getStartUri();
    if (uri?.isNotEmpty ?? false) _onRedirected(emit, uri);
    await _loadData();
    _yieldBasedOnCurrentState(emit);
  }

  Future<void> _handleOOBRedirect(
    OOBRedirectArrivedEvent event,
    Emitter<HomeState> emit,
  ) async {
    _onRedirected(emit, event.redirectUri);
  }

  _onRedirected(
    Emitter<HomeState> emit,
    String? uri,
  ) async {
    final dispatchTokenResponse =
        Uri.tryParse(uri ?? "")?.queryParameters["dispatchTokenResponse"];
    await _oobProcessUseCase.execute(dispatchTokenResponse).catchError((e) {
      _errorHandler.handle(e);
    });
  }

  Future<void> _initClient(Emitter<HomeState> emit) async {
    final configuration = await _configurationLoader.load();
    return await _clientProvider.init(configuration.sdkConfiguration, () async {
      add(ClientInitializedEvent());
    }).catchError((error) {
      _yieldBasedOnCurrentState(emit);
      _errorHandler.handle(error);
    });
  }

  Future<void> _loadData() async {
    _registeredAccounts =
        await _registeredAccountsUseCase.execute().catchError((error) {
      _errorHandler.handle(error);
      return Set<Account>.identity();
    });
    _authenticators =
        await _authenticatorsUseCase.execute().catchError((error) {
      _errorHandler.handle(error);
      return Set<Authenticator>.identity();
    });
  }

  void _yieldBasedOnCurrentState(Emitter<HomeState> emit) {
    emit(HomeLoadedState(_registeredAccounts.length));
  }

  Future<void> _handleReadQrCode(
    ReadQrCodeEvent event,
    Emitter<HomeState> emit,
  ) async {
    _globalNavigationManager.pushReadQrCode();
    _yieldBasedOnCurrentState(emit);
  }

  Future<void> _handleDeregister(
    DeregisterEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_configurationLoader.environment == AppEnvironment.identitySuite) {
      // In the example app Identity Suite environment the deregistration endpoint is guarded,
      // and as such we need to provide a cookie to the deregister call.
      // Also on Identity Suite a deregistration has to be authenticated for every user,
      // so batch deregistration is not really possible.
      await _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          operationType: OperationType.deregistration,
          accounts: _registeredAccounts,
        ),
      );
    } else {
      if (_registeredAccounts.isEmpty) {
        _errorHandler.handle(BusinessException.registeredAccountsNotFound());
      } else {
        await _deregisterAllUseCase
            .execute(
          accounts: _registeredAccounts,
          authorizationProvider: null,
        )
            .catchError((error) {
          _errorHandler.handle(error);
        });
      }
    }
  }

  Future<void> _handleInBandAuthentication(
    InBandAuthenticationEvent event,
    Emitter<HomeState> emit,
  ) async {
    // for in-band authentication a username is needed, that's why the account selector screen will be displayed
    if (_registeredAccounts.isEmpty) {
      _errorHandler.handle(BusinessException.registeredAccountsNotFound());
    } else {
      _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          operationType: OperationType.authentication,
          accounts: _registeredAccounts,
        ),
      );
    }
  }

  Future<void> _handleInBandRegister(
    InBandRegisterEvent event,
    Emitter<HomeState> emit,
  ) async {
    _globalNavigationManager.pushLegacyLogin();
    _yieldBasedOnCurrentState(emit);
  }

  Future<void> _handlePinChange(
    PinChangeEvent event,
    Emitter<HomeState> emit,
  ) async {
    // we should only pass the accounts to the account selection that already have a pin enrollment
    final filteredAuthenticators =
        _authenticators.where((element) => element.aaid.isPin);
    if (filteredAuthenticators.isEmpty) {
      return _errorHandler.handle(BusinessException.pinAuthenticatorNotFound());
    }
    final userEnrollment = _authenticators.first.userEnrollment;
    final eligibleAccounts = _registeredAccounts
        .where((element) => userEnrollment.isEnrolled(element.username))
        .toSet();
    // in case that there are multiple eligible accounts then we have to show the account selection screen
    // in case that there is only one account, then we can select it automatically
    if (eligibleAccounts.length > 1) {
      _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          accounts: eligibleAccounts,
          operationType: OperationType.pinChange,
          transactionConfirmationData: null,
        ),
      );
    } else if (eligibleAccounts.length == 1) {
      final parameter = PinParameter.credentialChange(
        username: eligibleAccounts.first.username,
      );
      _changePinUseCase
          .execute(username: eligibleAccounts.first.username)
          .catchError((error) {
        _errorHandler.handle(error);
      });
      _globalNavigationManager.pushPin(parameter);
    } else {
      _errorHandler.handle(BusinessException.accountsNotFound());
    }
  }

  Future<void> _handleChangeDeviceInformation(
    ChangeDeviceInformationEvent event,
    Emitter<HomeState> emit,
  ) async {
    _globalNavigationManager.pushChangeDeviceInformation();
  }

  Future<void> _handleAuthCloudApiRegistration(
    AuthCloudApiRegistrationEvent event,
    Emitter<HomeState> emit,
  ) async {
    _globalNavigationManager.pushAuthCloudApiRegistration();
  }

  Future<void> _handleLocalData(
    LocalDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    final state = event.state;
    if (state is LocalDataLoaded) {
      _registeredAccounts = state.accounts;
      _authenticators = state.authenticators;
      _yieldBasedOnCurrentState(emit);
    }
  }

  @override
  Future<void> close() {
    _deepLinkRepositorySubscription.cancel();
    _localDataSubscription.cancel();
    return super.close();
  }
}
