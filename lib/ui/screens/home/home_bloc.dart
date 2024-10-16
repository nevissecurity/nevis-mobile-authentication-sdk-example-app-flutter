// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/app_environment.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/deep_link_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_password_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_pin_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/delete_authenticators_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_all_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_process_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/navigation/credential_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DeepLinkRepository _deepLinkRepository;
  final ConfigurationLoader _configurationLoader;
  final ClientProvider _clientProvider;
  final OobProcessUseCase _oobProcessUseCase;
  final DeregisterAllUseCase _deregisterAllUseCase;
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

  HomeBloc(
    this._deepLinkRepository,
    this._configurationLoader,
    this._clientProvider,
    this._oobProcessUseCase,
    this._deregisterAllUseCase,
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
      add(HomeLocalDataEvent(state));
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
    on<CheckAndSyncDeviceInformationEvent>(
        _handleCheckAndSyncDeviceInformation);
    on<RemoveAuthenticatorEvent>(_handleRemoveAuthenticator);
    on<AuthCloudApiRegistrationEvent>(_handleAuthCloudApiRegistration);
    on<DeleteAuthenticatorsEvent>(_handleDeleteAuthenticators);
    on<HomeLocalDataEvent>(_handleLocalData);
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
    _localDataBloc.add(LoadAccountsEvent());
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

  void _yieldBasedOnCurrentState(Emitter<HomeState> emit) {
    emit(HomeLoadedState(_registeredAccounts.length));
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

  Future<void> _handleCheckAndSyncDeviceInformation(
    CheckAndSyncDeviceInformationEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _clientProvider.client.operations.deviceInformationCheck
        .onResult((checkResult) async {
          if (checkResult.mismatches.isNotEmpty) {
            debugPrint('Mismatches found during device information check!');
            for (var mismatch in checkResult.mismatches) {
              _printMismatch(mismatch);
            }
            debugPrint('Start syncing device information mismatches...');
            await _clientProvider.client.operations.deviceInformationSync
                .mismatches(checkResult.mismatches)
                .onResult((syncResult) {
                  if (syncResult.errors.isEmpty) {
                    debugPrint(
                        'Syncing device information mismatches succeeded!');
                    _localDataBloc.add(LoadAccountsEvent());
                    return;
                  }

                  debugPrint('Failed to sync device information mismatches!');
                  for (var error in syncResult.errors) {
                    _printSyncError(error);
                  }
                })
                .execute()
                .catchError((error) {
                  _errorHandler.handle(error);
                });
          } else if (checkResult.errors.isEmpty) {
            debugPrint('No mismatches found during device information check!');
          } else {
            debugPrint('Failed to check device information mismatches!');
            for (var error in checkResult.errors) {
              _printCheckError(error);
            }
          }
        })
        .execute()
        .catchError((error) {
          _errorHandler.handle(error);
        });
  }

  Future<void> _handleRemoveAuthenticator(
    RemoveAuthenticatorEvent event,
    Emitter<HomeState> emit,
  ) async {
    // for in-band authentication a username is needed, that's why the account selector screen will be displayed
    if (_registeredAccounts.isEmpty) {
      _errorHandler.handle(BusinessException.registeredAccountsNotFound());
    } else {
      final account = _registeredAccounts.first;
      final authenticator = _authenticators
          .where((element) => element.registration.isRegistered(
                account.username,
              ))
          .first;
      await _clientProvider.client.localData
          .deleteAuthenticator(
        username: account.username,
        aaid: authenticator.aaid,
      )
          .catchError((error) {
        _errorHandler.handle(error);
      });
      debugPrint(
          'Deleted authenticator with AAID ${authenticator.aaid} for username ${account.username}');
    }
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
    HomeLocalDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    final state = event.state;
    if (state is LocalDataLoaded) {
      _registeredAccounts = state.accounts;
      if (_registeredAccounts.isEmpty) {
        debugPrint("There are no registered accounts.");
      } else {
        debugPrint("Registered accounts:");
        for (var account in _registeredAccounts) {
          debugPrint("  ${jsonEncode(account.toJson())}");
        }
      }

      _authenticators = state.authenticators;
      if (_authenticators.isEmpty) {
        debugPrint("There are no available authenticators.");
      } else {
        debugPrint("Available authenticators:");
        for (var authenticator in _authenticators) {
          debugPrint("  ${jsonEncode(authenticator.toJson())}");
        }
      }

      if (state.deviceInformation == null) {
        debugPrint("There is no available device info.");
      } else {
        debugPrint("Available device info:");
        debugPrint("  ${jsonEncode(state.deviceInformation?.toJson())}");
      }
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

  void _printMismatch(DeviceInformationMismatch mismatch) {
    if (mismatch is MissingAuthenticatorInMobileDevice) {
      debugPrint(
          "MissingAuthenticatorInMobileDevice (${mismatch.keyId}, ${mismatch.aaid}, server: ${mismatch.server.baseUrl})");
    } else if (mismatch is MissingAuthenticatorInServer) {
      debugPrint(
          "MissingAuthenticatorInServer (${mismatch.keyId}, ${mismatch.aaid}, username: ${mismatch.account.username}, server: ${mismatch.account.server.baseUrl})");
    } else if (mismatch is MissingDeviceInformationInMobileDevice) {
      debugPrint(
          "MissingDeviceInformationInMobileDevice (${mismatch.dispatchTargetId}, server: ${mismatch.server.baseUrl})");
    } else if (mismatch is MissingDeviceInformationInServer) {
      debugPrint(
          "MissingDeviceInformationInServer ({${mismatch.idUsernamePair.username}, ${mismatch.idUsernamePair.identifier}}, server: ${mismatch.server.baseUrl})");
    } else if (mismatch is DeviceNameMismatch) {
      debugPrint(
          "DeviceNameMismatch (${mismatch.nameInServer}, ${mismatch.nameInMobileDevice}, server: ${mismatch.server.baseUrl})");
    } else if (mismatch is FcmRegistrationTokenMismatch) {
      debugPrint(
          "FcmRegistrationTokenMismatch (${mismatch.fcmRegistrationTokenInServer}, ${mismatch.fcmRegistrationTokenInMobileDevice}, server: ${mismatch.server.baseUrl})");
    }
  }

  void _printCheckError(DeviceInformationCheckError error) {
    if (error is DeviceInformationCheckClockSkewTooBig) {
      debugPrint(
          "DeviceInformationCheckClockSkewTooBig (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationCheckForbidden) {
      debugPrint(
          "DeviceInformationCheckForbidden (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationCheckNetworkError) {
      debugPrint(
          "DeviceInformationCheckNetworkError (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationCheckNoDeviceLockError) {
      debugPrint(
          "DeviceInformationCheckNoDeviceLockError (${error.description}, ${error.cause})");
    } else if (error is DeviceInformationCheckOperationNotSupportedByBackend) {
      debugPrint(
          "DeviceInformationCheckOperationNotSupportedByBackend (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationCheckUnknownError) {
      debugPrint(
          "DeviceInformationCheckUnknownError (${error.description}, ${error.cause}, server: ${error.server?.baseUrl})");
    }
  }

  void _printSyncError(DeviceInformationSyncError error) {
    if (error is DeviceInformationSyncClockSkewTooBig) {
      debugPrint(
          "DeviceInformationSyncClockSkewTooBig (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationSyncNetworkError) {
      debugPrint(
          "DeviceInformationSyncNetworkError (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationSyncNoDeviceLockError) {
      debugPrint(
          "DeviceInformationSyncNoDeviceLockError (${error.description}, ${error.cause})");
    } else if (error is DeviceInformationSyncOperationNotSupportedByBackend) {
      debugPrint(
          "DeviceInformationSyncOperationNotSupportedByBackend (${error.description}, ${error.cause}, server: ${error.server.baseUrl})");
    } else if (error is DeviceInformationSyncUnknownError) {
      debugPrint(
          "DeviceInformationSyncUnknownError (${error.description}, ${error.cause}, server: ${error.server?.baseUrl})");
    }
  }
}
