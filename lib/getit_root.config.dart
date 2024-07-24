// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart'
    as _i28;

import 'configuration/configuration_loader.dart' as _i17;
import 'data/cache/cache.dart' as _i5;
import 'data/cache/state_cache.dart' as _i7;
import 'data/datasource/deep_link/deep_link_datasource.dart' as _i11;
import 'data/datasource/login/login_datasource.dart' as _i8;
import 'data/repository/deep_link_repository_impl.dart' as _i36;
import 'data/repository/login_repository_impl.dart' as _i13;
import 'data/repository/state_repository_impl.dart' as _i20;
import 'domain/batch_call/batch_call.dart' as _i46;
import 'domain/blocs/domain_state/domain_bloc.dart' as _i25;
import 'domain/blocs/local_data/local_data_bloc.dart' as _i57;
import 'domain/client_provider/client_provider.dart' as _i49;
import 'domain/error/error_handler.dart' as _i39;
import 'domain/interaction/account_selector_impl.dart' as _i43;
import 'domain/interaction/authentication_authenticator_selector_impl.dart'
    as _i41;
import 'domain/interaction/biometric_user_verifier_impl.dart' as _i47;
import 'domain/interaction/device_passcode_user_verifier_impl.dart' as _i48;
import 'domain/interaction/fingerprint_user_verifier_impl.dart' as _i53;
import 'domain/interaction/pin_changer_impl.dart' as _i29;
import 'domain/interaction/pin_enroller_impl.dart' as _i37;
import 'domain/interaction/pin_user_verifier_impl.dart' as _i50;
import 'domain/interaction/registration_authenticator_selector_impl.dart'
    as _i40;
import 'domain/model/operation/operation_type.dart' as _i6;
import 'domain/model/operation/pin_change_state.dart' as _i10;
import 'domain/model/operation/pin_enrollment_state.dart' as _i15;
import 'domain/model/operation/user_interaction_operation_state.dart' as _i9;
import 'domain/repository/deep_link_repository.dart' as _i35;
import 'domain/repository/login_repository.dart' as _i12;
import 'domain/repository/state_repository.dart' as _i19;
import 'domain/usecase/auth_cloud_api_register_usecase.dart' as _i58;
import 'domain/usecase/authenticate_usecase.dart' as _i69;
import 'domain/usecase/authenticators_usecase.dart' as _i65;
import 'domain/usecase/biometric_listen_for_os_credentials_usecase.dart'
    as _i24;
import 'domain/usecase/cancel_pin_operation_usecase.dart' as _i45;
import 'domain/usecase/cancel_user_interaction_operation_usecase.dart' as _i27;
import 'domain/usecase/change_device_information_usecase.dart' as _i62;
import 'domain/usecase/change_pin_usecase.dart' as _i68;
import 'domain/usecase/create_device_information_usecase.dart' as _i16;
import 'domain/usecase/delete_authenticators_usecase.dart' as _i54;
import 'domain/usecase/deregister_all_usecase.dart' as _i59;
import 'domain/usecase/deregister_usecase.dart' as _i60;
import 'domain/usecase/device_information_usecase.dart' as _i67;
import 'domain/usecase/device_passcode_listen_for_os_credentials_usecase.dart'
    as _i23;
import 'domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart'
    as _i31;
import 'domain/usecase/login_usecase.dart' as _i26;
import 'domain/usecase/oob_payload_decode_usecase.dart' as _i64;
import 'domain/usecase/oob_process_usecase.dart' as _i73;
import 'domain/usecase/pause_listening_usecase.dart' as _i22;
import 'domain/usecase/provided_pins_usecase.dart' as _i44;
import 'domain/usecase/registered_accounts_usecase.dart' as _i51;
import 'domain/usecase/registration_usecase.dart' as _i61;
import 'domain/usecase/reset_user_interaction_state_usecase.dart' as _i30;
import 'domain/usecase/resume_listening_usecase.dart' as _i32;
import 'domain/usecase/select_account_usecase.dart' as _i21;
import 'domain/usecase/select_authenticator_usecase.dart' as _i34;
import 'domain/usecase/set_pin_usecase.dart' as _i38;
import 'domain/usecase/verify_pin_usecase.dart' as _i33;
import 'domain/validation/account_validator.dart' as _i18;
import 'domain/validation/authenticator_validator.dart' as _i14;
import 'navigation/app_navigation.dart' as _i4;
import 'navigation/global_navigation_manager.dart' as _i3;
import 'ui/app_state/app_bloc.dart' as _i72;
import 'ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart'
    as _i63;
import 'ui/screens/change_device_information/change_device_information_bloc.dart'
    as _i71;
import 'ui/screens/confirmation/confirmation_bloc.dart' as _i55;
import 'ui/screens/home/home_bloc.dart' as _i74;
import 'ui/screens/legacy_login/legacy_login_bloc.dart' as _i66;
import 'ui/screens/pin/pin_bloc.dart' as _i56;
import 'ui/screens/read_qr_code/read_qr_code_bloc.dart' as _i76;
import 'ui/screens/result/result_bloc.dart' as _i70;
import 'ui/screens/select_account/select_account_bloc.dart' as _i75;
import 'ui/screens/select_authenticator/select_authenticator_bloc.dart' as _i52;
import 'ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart'
    as _i42;

const String _authenticationCloud = 'authenticationCloud';
const String _identitySuite = 'identitySuite';

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.GlobalNavigationManager>(
      () => _i3.GlobalNavigationManager());
  gh.singleton<_i4.AppNavigation>(() => _i4.AppNavigation());
  gh.singleton<_i5.Cache<_i6.OperationType>>(
      () => _i7.OperationTypeCacheImpl());
  gh.factory<_i8.LoginDataSource>(() => _i8.LoginDataSourceImpl());
  gh.singleton<_i5.Cache<_i9.UserInteractionOperationState>>(
      () => _i7.UserInteractionOperationStateCacheImpl());
  gh.singleton<_i5.Cache<_i10.PinChangeState>>(
      () => _i7.ChangePinStateCacheImpl());
  gh.singleton<_i11.DeepLinkDataSource>(() => _i11.DeepLinkDataSourceImpl());
  gh.factory<_i12.LoginRepository>(
      () => _i13.LoginRepositoryImpl(gh<_i8.LoginDataSource>()));
  gh.factory<_i14.AuthenticatorValidator>(
      () => _i14.AuthenticatorValidatorImpl());
  gh.singleton<_i5.Cache<_i15.EnrollPinState>>(
      () => _i7.EnrollPinStateCacheImpl());
  gh.factory<_i16.CreateDeviceInformationUseCase>(
      () => _i16.CreateDeviceInformationUseCaseImpl());
  gh.singleton<_i17.ConfigurationLoader>(
    () => _i17.AuthenticationCloudConfigurationLoader(),
    registerFor: {_authenticationCloud},
  );
  gh.singleton<_i17.ConfigurationLoader>(
    () => _i17.IdentitySuiteConfigurationLoader(),
    registerFor: {_identitySuite},
  );
  gh.factory<_i18.AccountValidator>(() => _i18.AccountValidatorImpl());
  gh.factory<_i19.StateRepository<_i10.PinChangeState>>(() =>
      _i20.ChangePinStateRepositoryImpl(gh<_i5.Cache<_i10.PinChangeState>>()));
  gh.factory<_i19.StateRepository<_i9.UserInteractionOperationState>>(() =>
      _i20.UserInteractionOperationStateRepositoryImpl(
          gh<_i5.Cache<_i9.UserInteractionOperationState>>()));
  gh.factory<_i21.SelectAccountUseCase>(() => _i21.SelectAccountUseCaseImpl(
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i22.PauseListeningUseCase>(() => _i22.PauseListeningUseCaseImpl(
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i23.DevicePasscodeListenForOsCredentialsUseCase>(() =>
      _i23.DevicePasscodeListenForOsCredentialsUseCaseImpl(
          gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i24.BiometricListenForOsCredentialsUseCase>(() =>
      _i24.BiometricListenForOsCredentialsUseCaseImpl(
          gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i19.StateRepository<_i6.OperationType>>(() =>
      _i20.OperationTypeRepositoryImpl(gh<_i5.Cache<_i6.OperationType>>()));
  gh.singleton<_i25.DomainBloc>(() => _i25.DomainBloc(
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i26.LoginUseCase>(
      () => _i26.LoginUseCaseImpl(gh<_i12.LoginRepository>()));
  gh.factory<_i27.CancelUserInteractionOperationUseCase>(() =>
      _i27.CancelUserInteractionOperationUseCaseImpl(
          gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i19.StateRepository<_i15.EnrollPinState>>(() =>
      _i20.EnrollPinStateRepositoryImpl(gh<_i5.Cache<_i15.EnrollPinState>>()));
  gh.factory<_i28.PinChanger>(() => _i29.PinChangerImpl(
        gh<_i25.DomainBloc>(),
        gh<_i19.StateRepository<_i10.PinChangeState>>(),
      ));
  gh.factory<_i30.ResetUserInteractionStateUseCase>(() =>
      _i30.ResetUserInteractionStateUseCaseImpl(
          gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i31.FingerPrintListenForOsCredentialsUseCase>(() =>
      _i31.FingerPrintListenForOsCredentialsUseCaseImpl(
          gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i32.ResumeListeningUseCase>(() => _i32.ResumeListeningUseCaseImpl(
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i33.VerifyPinUseCase>(() => _i33.VerifyPinUseCaseImpl(
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i34.SelectAuthenticatorUseCase>(() =>
      _i34.SelectAuthenticatorUseCaseImpl(
          gh<_i19.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i35.DeepLinkRepository>(
      () => _i36.DeepLinkRepositoryImpl(gh<_i11.DeepLinkDataSource>()));
  gh.factory<_i28.PinEnroller>(() => _i37.PinEnrollerImpl(
        gh<_i19.StateRepository<_i15.EnrollPinState>>(),
        gh<_i25.DomainBloc>(),
      ));
  gh.factory<_i38.SetPinUseCase>(() =>
      _i38.SetPinUseCaseImpl(gh<_i19.StateRepository<_i15.EnrollPinState>>()));
  gh.factory<_i39.ErrorHandler>(() => _i39.ErrorHandlerImpl(
        gh<_i3.GlobalNavigationManager>(),
        gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i28.AuthenticatorSelector>(
    () => _i40.RegistrationAuthenticatorSelectorImpl(
      gh<_i25.DomainBloc>(),
      gh<_i17.ConfigurationLoader>(),
      gh<_i14.AuthenticatorValidator>(),
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_reg',
  );
  gh.factory<_i28.AuthenticatorSelector>(
    () => _i41.AuthenticationAuthenticatorSelectorImpl(
      gh<_i25.DomainBloc>(),
      gh<_i17.ConfigurationLoader>(),
      gh<_i14.AuthenticatorValidator>(),
      gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_auth',
  );
  gh.factory<_i42.TransactionConfirmationBloc>(
      () => _i42.TransactionConfirmationBloc(
            gh<_i39.ErrorHandler>(),
            gh<_i21.SelectAccountUseCase>(),
            gh<_i27.CancelUserInteractionOperationUseCase>(),
            gh<_i3.GlobalNavigationManager>(),
          ));
  gh.factory<_i28.AccountSelector>(() => _i43.AccountSelectorImpl(
        gh<_i25.DomainBloc>(),
        gh<_i39.ErrorHandler>(),
        gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i18.AccountValidator>(),
      ));
  gh.factory<_i44.ProvidedPinsUseCase>(() => _i44.ProvidedPinsUseCaseImpl(
        gh<_i19.StateRepository<_i10.PinChangeState>>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i45.CancelPinOperationUseCase>(
      () => _i45.CancelPinOperationUseCaseImpl(
            gh<_i19.StateRepository<_i15.EnrollPinState>>(),
            gh<_i19.StateRepository<_i10.PinChangeState>>(),
          ));
  gh.factory<_i46.BatchCall>(() => _i46.BatchCallImpl(
        gh<_i25.DomainBloc>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i28.BiometricUserVerifier>(() => _i47.BiometricUserVerifierImpl(
        gh<_i25.DomainBloc>(),
        gh<_i39.ErrorHandler>(),
        gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i28.DevicePasscodeUserVerifier>(
      () => _i48.DevicePasscodeUserVerifierImpl(
            gh<_i25.DomainBloc>(),
            gh<_i39.ErrorHandler>(),
            gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i49.ClientProvider>(() => _i49.ClientProviderImpl(
        gh<_i19.StateRepository<_i6.OperationType>>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i28.PinUserVerifier>(() => _i50.PinUserVerifierImpl(
        gh<_i25.DomainBloc>(),
        gh<_i39.ErrorHandler>(),
        gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i51.RegisteredAccountsUseCase>(
      () => _i51.RegisteredAccountsUseCaseImpl(gh<_i49.ClientProvider>()));
  gh.factory<_i52.SelectAuthenticatorBloc>(() => _i52.SelectAuthenticatorBloc(
        gh<_i34.SelectAuthenticatorUseCase>(),
        gh<_i3.GlobalNavigationManager>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i28.FingerprintUserVerifier>(
      () => _i53.FingerprintUserVerifierImpl(
            gh<_i25.DomainBloc>(),
            gh<_i39.ErrorHandler>(),
            gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i54.DeleteAuthenticatorsUseCase>(
      () => _i54.DeleteAuthenticatorsUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i19.StateRepository<_i6.OperationType>>(),
          ));
  gh.factory<_i55.ConfirmationBloc>(() => _i55.ConfirmationBloc(
        gh<_i24.BiometricListenForOsCredentialsUseCase>(),
        gh<_i31.FingerPrintListenForOsCredentialsUseCase>(),
        gh<_i23.DevicePasscodeListenForOsCredentialsUseCase>(),
        gh<_i27.CancelUserInteractionOperationUseCase>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i56.PinBloc>(() => _i56.PinBloc(
        gh<_i25.DomainBloc>(),
        gh<_i45.CancelPinOperationUseCase>(),
        gh<_i44.ProvidedPinsUseCase>(),
        gh<_i27.CancelUserInteractionOperationUseCase>(),
        gh<_i38.SetPinUseCase>(),
        gh<_i33.VerifyPinUseCase>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.singleton<_i57.LocalDataBloc>(() => _i57.LocalDataBloc(
        gh<_i49.ClientProvider>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i58.AuthCloudApiRegisterUseCase>(
      () => _i58.AuthCloudApiRegisterUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i16.CreateDeviceInformationUseCase>(),
            gh<_i28.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
            gh<_i28.PinEnroller>(),
            gh<_i28.BiometricUserVerifier>(),
            gh<_i28.DevicePasscodeUserVerifier>(),
            gh<_i28.FingerprintUserVerifier>(),
            gh<_i25.DomainBloc>(),
            gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
            gh<_i19.StateRepository<_i6.OperationType>>(),
            gh<_i39.ErrorHandler>(),
          ));
  gh.factory<_i59.DeregisterAllUseCase>(() => _i59.DeregisterAllUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i60.DeregisterUseCase>(() => _i60.DeregisterUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i61.RegistrationUseCase>(() => _i61.RegistrationUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i16.CreateDeviceInformationUseCase>(),
        gh<_i28.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i28.PinEnroller>(),
        gh<_i28.BiometricUserVerifier>(),
        gh<_i28.DevicePasscodeUserVerifier>(),
        gh<_i28.FingerprintUserVerifier>(),
        gh<_i25.DomainBloc>(),
        gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i62.ChangeDeviceInformationUseCase>(
      () => _i62.ChangeDeviceInformationUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i19.StateRepository<_i6.OperationType>>(),
            gh<_i25.DomainBloc>(),
            gh<_i39.ErrorHandler>(),
          ));
  gh.factory<_i63.AuthCloudApiRegistrationBloc>(
      () => _i63.AuthCloudApiRegistrationBloc(
            gh<_i3.GlobalNavigationManager>(),
            gh<_i58.AuthCloudApiRegisterUseCase>(),
            gh<_i39.ErrorHandler>(),
          ));
  gh.factory<_i64.OobPayloadDecodeUseCase>(
      () => _i64.OobPayloadDecodeUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i19.StateRepository<_i6.OperationType>>(),
            gh<_i39.ErrorHandler>(),
          ));
  gh.factory<_i65.AuthenticatorsUseCase>(
      () => _i65.AuthenticatorsUseCaseImpl(gh<_i49.ClientProvider>()));
  gh.factory<_i66.LegacyLoginBloc>(() => _i66.LegacyLoginBloc(
        gh<_i17.ConfigurationLoader>(),
        gh<_i26.LoginUseCase>(),
        gh<_i61.RegistrationUseCase>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i67.DeviceInformationUseCase>(
      () => _i67.DeviceInformationUseCaseImpl(gh<_i49.ClientProvider>()));
  gh.factory<_i68.ChangePinUseCase>(() => _i68.ChangePinUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i28.PinChanger>(),
        gh<_i25.DomainBloc>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
        gh<_i19.StateRepository<_i10.PinChangeState>>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i69.AuthenticateUseCase>(() => _i69.AuthenticateUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i28.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i28.BiometricUserVerifier>(),
        gh<_i28.DevicePasscodeUserVerifier>(),
        gh<_i28.FingerprintUserVerifier>(),
        gh<_i28.PinUserVerifier>(),
        gh<_i25.DomainBloc>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i70.ResultBloc>(() => _i70.ResultBloc(
        gh<_i3.GlobalNavigationManager>(),
        gh<_i57.LocalDataBloc>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i71.ChangeDeviceInformationBloc>(
      () => _i71.ChangeDeviceInformationBloc(
            gh<_i3.GlobalNavigationManager>(),
            gh<_i62.ChangeDeviceInformationUseCase>(),
            gh<_i67.DeviceInformationUseCase>(),
            gh<_i39.ErrorHandler>(),
          ));
  gh.singleton<_i72.AppBloc>(() => _i72.AppBloc(
        gh<_i65.AuthenticatorsUseCase>(),
        gh<_i60.DeregisterUseCase>(),
        gh<_i17.ConfigurationLoader>(),
        gh<_i39.ErrorHandler>(),
        gh<_i25.DomainBloc>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i73.OobProcessUseCase>(() => _i73.OobProcessUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i16.CreateDeviceInformationUseCase>(),
        gh<_i64.OobPayloadDecodeUseCase>(),
        gh<_i28.AccountSelector>(),
        gh<_i28.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i28.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i28.PinEnroller>(),
        gh<_i28.BiometricUserVerifier>(),
        gh<_i28.DevicePasscodeUserVerifier>(),
        gh<_i28.PinUserVerifier>(),
        gh<_i28.FingerprintUserVerifier>(),
        gh<_i25.DomainBloc>(),
        gh<_i19.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i19.StateRepository<_i6.OperationType>>(),
        gh<_i39.ErrorHandler>(),
      ));
  gh.factory<_i74.HomeBloc>(() => _i74.HomeBloc(
        gh<_i35.DeepLinkRepository>(),
        gh<_i17.ConfigurationLoader>(),
        gh<_i49.ClientProvider>(),
        gh<_i73.OobProcessUseCase>(),
        gh<_i51.RegisteredAccountsUseCase>(),
        gh<_i59.DeregisterAllUseCase>(),
        gh<_i65.AuthenticatorsUseCase>(),
        gh<_i68.ChangePinUseCase>(),
        gh<_i54.DeleteAuthenticatorsUseCase>(),
        gh<_i57.LocalDataBloc>(),
        gh<_i39.ErrorHandler>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i75.SelectAccountBloc>(() => _i75.SelectAccountBloc(
        gh<_i69.AuthenticateUseCase>(),
        gh<_i21.SelectAccountUseCase>(),
        gh<_i68.ChangePinUseCase>(),
        gh<_i39.ErrorHandler>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i76.ReadQrCodeBloc>(() => _i76.ReadQrCodeBloc(
        gh<_i73.OobProcessUseCase>(),
        gh<_i39.ErrorHandler>(),
      ));
  return getIt;
}
