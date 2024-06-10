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
    as _i34;

import 'configuration/configuration_loader.dart' as _i16;
import 'data/cache/cache.dart' as _i5;
import 'data/cache/state_cache.dart' as _i7;
import 'data/datasource/deep_link/deep_link_datasource.dart' as _i11;
import 'data/datasource/login/login_datasource.dart' as _i8;
import 'data/repository/deep_link_repository_impl.dart' as _i33;
import 'data/repository/login_repository_impl.dart' as _i13;
import 'data/repository/state_repository_impl.dart' as _i19;
import 'domain/batch_call/batch_call.dart' as _i47;
import 'domain/blocs/domain_state/domain_bloc.dart' as _i24;
import 'domain/blocs/local_data/local_data_bloc.dart' as _i56;
import 'domain/client_provider/client_provider.dart' as _i48;
import 'domain/error/error_handler.dart' as _i37;
import 'domain/interaction/account_selector.dart' as _i39;
import 'domain/interaction/authentication_authenticator_selector.dart' as _i42;
import 'domain/interaction/biometric_user_verifier.dart' as _i49;
import 'domain/interaction/device_passcode_user_verifier.dart' as _i43;
import 'domain/interaction/fingerprint_user_verifier.dart' as _i51;
import 'domain/interaction/pin_changer.dart' as _i41;
import 'domain/interaction/pin_enroller.dart' as _i35;
import 'domain/interaction/pin_user_verifier.dart' as _i44;
import 'domain/interaction/registration_authenticator_selector.dart' as _i45;
import 'domain/model/operation/operation_type.dart' as _i6;
import 'domain/model/operation/pin_change_state.dart' as _i10;
import 'domain/model/operation/pin_enrollment_state.dart' as _i14;
import 'domain/model/operation/user_interaction_operation_state.dart' as _i9;
import 'domain/repository/deep_link_repository.dart' as _i32;
import 'domain/repository/login_repository.dart' as _i12;
import 'domain/repository/state_repository.dart' as _i18;
import 'domain/usecase/auth_cloud_api_register_usecase.dart' as _i57;
import 'domain/usecase/authenticate_usecase.dart' as _i68;
import 'domain/usecase/authenticators_usecase.dart' as _i64;
import 'domain/usecase/biometric_listen_for_os_credentials_usecase.dart'
    as _i23;
import 'domain/usecase/cancel_pin_operation_usecase.dart' as _i46;
import 'domain/usecase/cancel_user_interaction_operation_usecase.dart' as _i26;
import 'domain/usecase/change_device_information_usecase.dart' as _i61;
import 'domain/usecase/change_pin_usecase.dart' as _i67;
import 'domain/usecase/create_device_information_usecase.dart' as _i15;
import 'domain/usecase/delete_authenticators_usecase.dart' as _i53;
import 'domain/usecase/deregister_all_usecase.dart' as _i58;
import 'domain/usecase/deregister_usecase.dart' as _i59;
import 'domain/usecase/device_information_usecase.dart' as _i66;
import 'domain/usecase/device_passcode_listen_for_os_credentials_usecase.dart'
    as _i22;
import 'domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart'
    as _i28;
import 'domain/usecase/login_usecase.dart' as _i25;
import 'domain/usecase/oob_payload_decode_usecase.dart' as _i63;
import 'domain/usecase/oob_process_usecase.dart' as _i72;
import 'domain/usecase/pause_listening_usecase.dart' as _i21;
import 'domain/usecase/provided_pins_usecase.dart' as _i40;
import 'domain/usecase/registered_accounts_usecase.dart' as _i50;
import 'domain/usecase/registration_usecase.dart' as _i60;
import 'domain/usecase/reset_user_interaction_state_usecase.dart' as _i27;
import 'domain/usecase/resume_listening_usecase.dart' as _i29;
import 'domain/usecase/select_account_usecase.dart' as _i20;
import 'domain/usecase/select_authenticator_usecase.dart' as _i31;
import 'domain/usecase/set_pin_usecase.dart' as _i36;
import 'domain/usecase/verify_pin_usecase.dart' as _i30;
import 'domain/validation/account_validator.dart' as _i17;
import 'navigation/app_navigation.dart' as _i4;
import 'navigation/global_navigation_manager.dart' as _i3;
import 'ui/app_state/app_bloc.dart' as _i71;
import 'ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart'
    as _i62;
import 'ui/screens/change_device_information/change_device_information_bloc.dart'
    as _i70;
import 'ui/screens/confirmation/confirmation_bloc.dart' as _i54;
import 'ui/screens/home/home_bloc.dart' as _i73;
import 'ui/screens/legacy_login/legacy_login_bloc.dart' as _i65;
import 'ui/screens/pin/pin_bloc.dart' as _i55;
import 'ui/screens/read_qr_code/read_qr_code_bloc.dart' as _i75;
import 'ui/screens/result/result_bloc.dart' as _i69;
import 'ui/screens/select_account/select_account_bloc.dart' as _i74;
import 'ui/screens/select_authenticator/select_authenticator_bloc.dart' as _i52;
import 'ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart'
    as _i38;

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
  gh.singleton<_i5.Cache<_i14.EnrollPinState>>(
      () => _i7.EnrollPinStateCacheImpl());
  gh.factory<_i15.CreateDeviceInformationUseCase>(
      () => _i15.CreateDeviceInformationUseCaseImpl());
  gh.singleton<_i16.ConfigurationLoader>(
    () => _i16.AuthenticationCloudConfigurationLoader(),
    registerFor: {_authenticationCloud},
  );
  gh.singleton<_i16.ConfigurationLoader>(
    () => _i16.IdentitySuiteConfigurationLoader(),
    registerFor: {_identitySuite},
  );
  gh.factory<_i17.AccountValidator>(() => _i17.AccountValidatorImpl());
  gh.factory<_i18.StateRepository<_i10.PinChangeState>>(() =>
      _i19.ChangePinStateRepositoryImpl(gh<_i5.Cache<_i10.PinChangeState>>()));
  gh.factory<_i18.StateRepository<_i9.UserInteractionOperationState>>(() =>
      _i19.UserInteractionOperationStateRepositoryImpl(
          gh<_i5.Cache<_i9.UserInteractionOperationState>>()));
  gh.factory<_i20.SelectAccountUseCase>(() => _i20.SelectAccountUseCaseImpl(
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i21.PauseListeningUseCase>(() => _i21.PauseListeningUseCaseImpl(
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i22.DevicePasscodeListenForOsCredentialsUseCase>(() =>
      _i22.DevicePasscodeListenForOsCredentialsUseCaseImpl(
          gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i23.BiometricListenForOsCredentialsUseCase>(() =>
      _i23.BiometricListenForOsCredentialsUseCaseImpl(
          gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i18.StateRepository<_i6.OperationType>>(() =>
      _i19.OperationTypeRepositoryImpl(gh<_i5.Cache<_i6.OperationType>>()));
  gh.singleton<_i24.DomainBloc>(() => _i24.DomainBloc(
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i25.LoginUseCase>(
      () => _i25.LoginUseCaseImpl(gh<_i12.LoginRepository>()));
  gh.factory<_i26.CancelUserInteractionOperationUseCase>(() =>
      _i26.CancelUserInteractionOperationUseCaseImpl(
          gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i18.StateRepository<_i14.EnrollPinState>>(() =>
      _i19.EnrollPinStateRepositoryImpl(gh<_i5.Cache<_i14.EnrollPinState>>()));
  gh.factory<_i27.ResetUserInteractionStateUseCase>(() =>
      _i27.ResetUserInteractionStateUseCaseImpl(
          gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i28.FingerPrintListenForOsCredentialsUseCase>(() =>
      _i28.FingerPrintListenForOsCredentialsUseCaseImpl(
          gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i29.ResumeListeningUseCase>(() => _i29.ResumeListeningUseCaseImpl(
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i30.VerifyPinUseCase>(() => _i30.VerifyPinUseCaseImpl(
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i31.SelectAuthenticatorUseCase>(() =>
      _i31.SelectAuthenticatorUseCaseImpl(
          gh<_i18.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i32.DeepLinkRepository>(
      () => _i33.DeepLinkRepositoryImpl(gh<_i11.DeepLinkDataSource>()));
  gh.factory<_i34.PinEnroller>(() => _i35.PinEnrollerImpl(
        gh<_i18.StateRepository<_i14.EnrollPinState>>(),
        gh<_i24.DomainBloc>(),
      ));
  gh.factory<_i36.SetPinUseCase>(() =>
      _i36.SetPinUseCaseImpl(gh<_i18.StateRepository<_i14.EnrollPinState>>()));
  gh.factory<_i37.ErrorHandler>(() => _i37.ErrorHandlerImpl(
        gh<_i3.GlobalNavigationManager>(),
        gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i38.TransactionConfirmationBloc>(
      () => _i38.TransactionConfirmationBloc(
            gh<_i37.ErrorHandler>(),
            gh<_i20.SelectAccountUseCase>(),
            gh<_i26.CancelUserInteractionOperationUseCase>(),
            gh<_i3.GlobalNavigationManager>(),
          ));
  gh.factory<_i34.AccountSelector>(() => _i39.AccountSelectorImpl(
        gh<_i24.DomainBloc>(),
        gh<_i37.ErrorHandler>(),
        gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i17.AccountValidator>(),
      ));
  gh.factory<_i40.ProvidedPinsUseCase>(() => _i40.ProvidedPinsUseCaseImpl(
        gh<_i18.StateRepository<_i10.PinChangeState>>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i34.PinChanger>(() => _i41.PinChangerImpl(
        gh<_i24.DomainBloc>(),
        gh<_i18.StateRepository<_i10.PinChangeState>>(),
      ));
  gh.factory<_i34.AuthenticatorSelector>(
    () => _i42.AuthenticationAuthenticatorSelectorImpl(
      gh<_i24.DomainBloc>(),
      gh<_i16.ConfigurationLoader>(),
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_auth',
  );
  gh.factory<_i34.DevicePasscodeUserVerifier>(
      () => _i43.DevicePasscodeUserVerifierImpl(
            gh<_i24.DomainBloc>(),
            gh<_i37.ErrorHandler>(),
            gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i34.PinUserVerifier>(() => _i44.PinUserVerifierImpl(
        gh<_i24.DomainBloc>(),
        gh<_i37.ErrorHandler>(),
        gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i34.AuthenticatorSelector>(
    () => _i45.RegistrationAuthenticatorSelectorImpl(
      gh<_i24.DomainBloc>(),
      gh<_i16.ConfigurationLoader>(),
      gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_reg',
  );
  gh.factory<_i46.CancelPinOperationUseCase>(
      () => _i46.CancelPinOperationUseCaseImpl(
            gh<_i18.StateRepository<_i14.EnrollPinState>>(),
            gh<_i18.StateRepository<_i10.PinChangeState>>(),
          ));
  gh.factory<_i47.BatchCall>(() => _i47.BatchCallImpl(
        gh<_i24.DomainBloc>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i48.ClientProvider>(() => _i48.ClientProviderImpl(
        gh<_i18.StateRepository<_i6.OperationType>>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i34.BiometricUserVerifier>(() => _i49.BiometricUserVerifierImpl(
        gh<_i24.DomainBloc>(),
        gh<_i37.ErrorHandler>(),
        gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i50.RegisteredAccountsUseCase>(
      () => _i50.RegisteredAccountsUseCaseImpl(gh<_i48.ClientProvider>()));
  gh.factory<_i34.FingerprintUserVerifier>(
      () => _i51.FingerprintUserVerifierImpl(
            gh<_i24.DomainBloc>(),
            gh<_i37.ErrorHandler>(),
            gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i52.SelectAuthenticatorBloc>(() => _i52.SelectAuthenticatorBloc(
        gh<_i31.SelectAuthenticatorUseCase>(),
        gh<_i3.GlobalNavigationManager>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i53.DeleteAuthenticatorsUseCase>(
      () => _i53.DeleteAuthenticatorsUseCaseImpl(
            gh<_i48.ClientProvider>(),
            gh<_i18.StateRepository<_i6.OperationType>>(),
          ));
  gh.factory<_i54.ConfirmationBloc>(() => _i54.ConfirmationBloc(
        gh<_i23.BiometricListenForOsCredentialsUseCase>(),
        gh<_i28.FingerPrintListenForOsCredentialsUseCase>(),
        gh<_i22.DevicePasscodeListenForOsCredentialsUseCase>(),
        gh<_i26.CancelUserInteractionOperationUseCase>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i55.PinBloc>(() => _i55.PinBloc(
        gh<_i24.DomainBloc>(),
        gh<_i46.CancelPinOperationUseCase>(),
        gh<_i40.ProvidedPinsUseCase>(),
        gh<_i26.CancelUserInteractionOperationUseCase>(),
        gh<_i36.SetPinUseCase>(),
        gh<_i30.VerifyPinUseCase>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.singleton<_i56.LocalDataBloc>(() => _i56.LocalDataBloc(
        gh<_i48.ClientProvider>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i57.AuthCloudApiRegisterUseCase>(
      () => _i57.AuthCloudApiRegisterUseCaseImpl(
            gh<_i48.ClientProvider>(),
            gh<_i15.CreateDeviceInformationUseCase>(),
            gh<_i34.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
            gh<_i34.PinEnroller>(),
            gh<_i34.BiometricUserVerifier>(),
            gh<_i34.DevicePasscodeUserVerifier>(),
            gh<_i34.FingerprintUserVerifier>(),
            gh<_i24.DomainBloc>(),
            gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
            gh<_i18.StateRepository<_i6.OperationType>>(),
            gh<_i37.ErrorHandler>(),
          ));
  gh.factory<_i58.DeregisterAllUseCase>(() => _i58.DeregisterAllUseCaseImpl(
        gh<_i48.ClientProvider>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i59.DeregisterUseCase>(() => _i59.DeregisterUseCaseImpl(
        gh<_i48.ClientProvider>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i60.RegistrationUseCase>(() => _i60.RegistrationUseCaseImpl(
        gh<_i48.ClientProvider>(),
        gh<_i15.CreateDeviceInformationUseCase>(),
        gh<_i34.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i34.PinEnroller>(),
        gh<_i34.BiometricUserVerifier>(),
        gh<_i34.DevicePasscodeUserVerifier>(),
        gh<_i34.FingerprintUserVerifier>(),
        gh<_i24.DomainBloc>(),
        gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i61.ChangeDeviceInformationUseCase>(
      () => _i61.ChangeDeviceInformationUseCaseImpl(
            gh<_i48.ClientProvider>(),
            gh<_i18.StateRepository<_i6.OperationType>>(),
            gh<_i24.DomainBloc>(),
            gh<_i37.ErrorHandler>(),
          ));
  gh.factory<_i62.AuthCloudApiRegistrationBloc>(
      () => _i62.AuthCloudApiRegistrationBloc(
            gh<_i3.GlobalNavigationManager>(),
            gh<_i57.AuthCloudApiRegisterUseCase>(),
            gh<_i37.ErrorHandler>(),
          ));
  gh.factory<_i63.OobPayloadDecodeUseCase>(
      () => _i63.OobPayloadDecodeUseCaseImpl(
            gh<_i48.ClientProvider>(),
            gh<_i18.StateRepository<_i6.OperationType>>(),
            gh<_i37.ErrorHandler>(),
          ));
  gh.factory<_i64.AuthenticatorsUseCase>(
      () => _i64.AuthenticatorsUseCaseImpl(gh<_i48.ClientProvider>()));
  gh.factory<_i65.LegacyLoginBloc>(() => _i65.LegacyLoginBloc(
        gh<_i16.ConfigurationLoader>(),
        gh<_i25.LoginUseCase>(),
        gh<_i60.RegistrationUseCase>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i66.DeviceInformationUseCase>(
      () => _i66.DeviceInformationUseCaseImpl(gh<_i48.ClientProvider>()));
  gh.factory<_i67.ChangePinUseCase>(() => _i67.ChangePinUseCaseImpl(
        gh<_i48.ClientProvider>(),
        gh<_i34.PinChanger>(),
        gh<_i24.DomainBloc>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
        gh<_i18.StateRepository<_i10.PinChangeState>>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i68.AuthenticateUseCase>(() => _i68.AuthenticateUseCaseImpl(
        gh<_i48.ClientProvider>(),
        gh<_i34.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i34.BiometricUserVerifier>(),
        gh<_i34.DevicePasscodeUserVerifier>(),
        gh<_i34.FingerprintUserVerifier>(),
        gh<_i34.PinUserVerifier>(),
        gh<_i24.DomainBloc>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i69.ResultBloc>(() => _i69.ResultBloc(
        gh<_i3.GlobalNavigationManager>(),
        gh<_i56.LocalDataBloc>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i70.ChangeDeviceInformationBloc>(
      () => _i70.ChangeDeviceInformationBloc(
            gh<_i3.GlobalNavigationManager>(),
            gh<_i61.ChangeDeviceInformationUseCase>(),
            gh<_i66.DeviceInformationUseCase>(),
            gh<_i37.ErrorHandler>(),
          ));
  gh.singleton<_i71.AppBloc>(() => _i71.AppBloc(
        gh<_i64.AuthenticatorsUseCase>(),
        gh<_i59.DeregisterUseCase>(),
        gh<_i16.ConfigurationLoader>(),
        gh<_i37.ErrorHandler>(),
        gh<_i24.DomainBloc>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i72.OobProcessUseCase>(() => _i72.OobProcessUseCaseImpl(
        gh<_i48.ClientProvider>(),
        gh<_i15.CreateDeviceInformationUseCase>(),
        gh<_i63.OobPayloadDecodeUseCase>(),
        gh<_i34.AccountSelector>(),
        gh<_i34.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i34.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i34.PinEnroller>(),
        gh<_i34.BiometricUserVerifier>(),
        gh<_i34.DevicePasscodeUserVerifier>(),
        gh<_i34.PinUserVerifier>(),
        gh<_i34.FingerprintUserVerifier>(),
        gh<_i24.DomainBloc>(),
        gh<_i18.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i18.StateRepository<_i6.OperationType>>(),
        gh<_i37.ErrorHandler>(),
      ));
  gh.factory<_i73.HomeBloc>(() => _i73.HomeBloc(
        gh<_i32.DeepLinkRepository>(),
        gh<_i16.ConfigurationLoader>(),
        gh<_i48.ClientProvider>(),
        gh<_i72.OobProcessUseCase>(),
        gh<_i50.RegisteredAccountsUseCase>(),
        gh<_i58.DeregisterAllUseCase>(),
        gh<_i64.AuthenticatorsUseCase>(),
        gh<_i67.ChangePinUseCase>(),
        gh<_i53.DeleteAuthenticatorsUseCase>(),
        gh<_i56.LocalDataBloc>(),
        gh<_i37.ErrorHandler>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i74.SelectAccountBloc>(() => _i74.SelectAccountBloc(
        gh<_i68.AuthenticateUseCase>(),
        gh<_i20.SelectAccountUseCase>(),
        gh<_i67.ChangePinUseCase>(),
        gh<_i37.ErrorHandler>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i75.ReadQrCodeBloc>(() => _i75.ReadQrCodeBloc(
        gh<_i72.OobProcessUseCase>(),
        gh<_i37.ErrorHandler>(),
      ));
  return getIt;
}
