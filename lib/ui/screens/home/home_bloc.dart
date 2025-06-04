// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:io' show Platform;

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
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_password_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_pin_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/delete_authenticators_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_all_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_process_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registered_accounts_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/navigation/credential_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/version_utils.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final ChangePasswordUseCase _changePasswordUseCase;
  final DeleteAuthenticatorsUseCase _deleteAuthenticatorsUseCase;
  final LocalDataBloc _localDataBloc;
  final ErrorHandler _errorHandler;
  final GlobalNavigationManager _globalNavigationManager;
  late StreamSubscription _localDataSubscription;
  late StreamSubscription _deepLinkRepositorySubscription;

  Set<Account> _registeredAccounts = {};
  Set<Authenticator> _authenticators = {};
  String? _sdkVersion;
  String? _facetId;
  String? _certificateFingerprint;

  HomeBloc(
    this._deepLinkRepository,
    this._configurationLoader,
    this._clientProvider,
    this._oobProcessUseCase,
    this._registeredAccountsUseCase,
    this._deregisterAllUseCase,
    this._authenticatorsUseCase,
    this._changePinUseCase,
    this._changePasswordUseCase,
    this._deleteAuthenticatorsUseCase,
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
    on<PasswordChangeEvent>(_handlePasswordChange);
    on<ChangeDeviceInformationEvent>(_handleChangeDeviceInformation);
    on<AuthCloudApiRegistrationEvent>(_handleAuthCloudApiRegistration);
    on<DeleteAuthenticatorsEvent>(_handleDeleteAuthenticators);
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
    final sdkConfiguration = await _configurationLoader.sdkConfiguration();
    return await _clientProvider.init(sdkConfiguration, () async {
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

    if (Platform.isIOS) {
      final metaData = await MetaData.iosMetaData;
      _sdkVersion = metaData?.mobileAuthenticationVersion.formatted();
      _facetId = metaData?.applicationFacetId;
    } else if (Platform.isAndroid) {
      final metaData = await MetaData.androidMetaData;
      _sdkVersion = metaData?.mobileAuthenticationVersion.formatted();
      _facetId = metaData?.applicationFacetId;
      _certificateFingerprint = metaData?.signingCertificateSha256;
    }
  }

  void _yieldBasedOnCurrentState(Emitter<HomeState> emit) {
    emit(
      HomeLoadedState(
        _registeredAccounts.length,
        _sdkVersion,
        _facetId,
        _certificateFingerprint,
      ),
    );
  }

  Future<void> _handleReadQrCode(
    ReadQrCodeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (await Permission.camera.request().isGranted) {
      _globalNavigationManager.pushReadQrCode();
    } else {
      _errorHandler.handle(BusinessException.cameraAccessDenied());
    }
  }

  Future<void> _handleDeregister(
    DeregisterEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_registeredAccounts.isEmpty) {
      _errorHandler.handle(BusinessException.registeredAccountsNotFound());
      return;
    }

    // NOTE: The de-registration process is executed differently for Authentication
    // Cloud and Identity Suite environments.
    // - In case of Authentication Cloud all of the registered accounts will be
    // de-registered one by one.
    // - In case of Identity Suite only one account can be de-registered at a time,
    // this is the reason the user will be asked to select the account first.
    if (_configurationLoader.environment == AppEnvironment.identitySuite) {
      await _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          operationType: OperationType.deregistration,
          accounts: _registeredAccounts,
        ),
      );
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

  Future<void> _handleInBandAuthentication(
    InBandAuthenticationEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_registeredAccounts.isEmpty) {
      _errorHandler.handle(BusinessException.registeredAccountsNotFound());
      return;
    }

    // for in-band authentication a username is needed, this is the reason the
    // user will be asked to select the account first.
    _globalNavigationManager.pushSelectAccount(
      SelectAccountParameter(
        operationType: OperationType.authentication,
        accounts: _registeredAccounts,
      ),
    );
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
    // we should only pass the accounts to the account selection that already
    // have a pin enrollment
    Set<Account> eligibleAccounts = {};
    for (final account in _registeredAccounts) {
      if (_isEnrolled(account.username, Aaid.pin)) {
        eligibleAccounts.add(account);
      }
    }

    if (eligibleAccounts.length > 1) {
      // in case that there are multiple eligible accounts then we have to show
      // the account selection screen
      _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          accounts: eligibleAccounts,
          operationType: OperationType.pinChange,
        ),
      );
    } else if (eligibleAccounts.length == 1) {
      // in case that there is only one account, then we can select it automatically
      _startPinChange(eligibleAccounts.first.username);
    } else {
      _errorHandler.handle(BusinessException.accountsNotFound());
    }
  }

  Future<void> _handlePasswordChange(
    PasswordChangeEvent event,
    Emitter<HomeState> emit,
  ) async {
    // we should only pass the accounts to the account selection that already
    // have a password enrollment
    Set<Account> eligibleAccounts = {};
    for (final account in _registeredAccounts) {
      if (_isEnrolled(account.username, Aaid.password)) {
        eligibleAccounts.add(account);
      }
    }

    if (eligibleAccounts.length > 1) {
      // in case that there are multiple eligible accounts then we have to show
      // the account selection screen
      _globalNavigationManager.pushSelectAccount(
        SelectAccountParameter(
          accounts: eligibleAccounts,
          operationType: OperationType.passwordChange,
        ),
      );
    } else if (eligibleAccounts.length == 1) {
      // in case that there is only one account, then we can select it automatically
      _startPasswordChange(eligibleAccounts.first.username);
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

  Future<void> _handleDeleteAuthenticators(
    DeleteAuthenticatorsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_registeredAccounts.isEmpty) {
      return _errorHandler.handle(
        BusinessException.registeredAccountsNotFound(),
      );
    }

    await _deleteAuthenticatorsUseCase
        .execute(accounts: _registeredAccounts)
        .catchError((error) {
      _errorHandler.handle(error);
    });
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

  Future<void> _startPinChange(String username) async {
    final parameter = CredentialParameter.pinChange(
      username: username,
    );
    _changePinUseCase
        .execute(username: username) //
        .catchError((error) {
      _errorHandler.handle(error);
    });
    _globalNavigationManager.pushCredential(parameter);
  }

  Future<void> _startPasswordChange(String username) async {
    final parameter = CredentialParameter.passwordChange(
      username: username,
    );
    _changePasswordUseCase
        .execute(username: username) //
        .catchError((error) {
      _errorHandler.handle(error);
    });
    _globalNavigationManager.pushCredential(parameter);
  }

  bool _isEnrolled(String username, Aaid aaid) {
    final authenticators =
        _authenticators.where((element) => element.aaid == aaid.rawValue);
    if (authenticators.isEmpty) {
      return false;
    }

    return authenticators.first.userEnrollment.isEnrolled(username);
  }

  @override
  Future<void> close() {
    _deepLinkRepositorySubscription.cancel();
    _localDataSubscription.cancel();
    return super.close();
  }
}
