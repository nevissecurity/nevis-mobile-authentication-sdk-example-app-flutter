// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart' as _i30;

import 'configuration/configuration_loader.dart' as _i11;
import 'data/cache/cache.dart' as _i5;
import 'data/cache/state_cache.dart' as _i7;
import 'data/datasource/deep_link/deep_link_datasource.dart' as _i13;
import 'data/datasource/login/login_datasource.dart' as _i17;
import 'data/repository/deep_link_repository_impl.dart' as _i15;
import 'data/repository/login_repository_impl.dart' as _i19;
import 'data/repository/state_repository_impl.dart' as _i22;
import 'domain/batch_call/batch_call.dart' as _i45;
import 'domain/blocs/domain_state/domain_bloc.dart' as _i27;
import 'domain/blocs/local_data/local_data_bloc.dart' as _i51;
import 'domain/changer/pin_changer.dart' as _i33;
import 'domain/client_provider/client_provider.dart' as _i47;
import 'domain/enroller/pin_enroller.dart' as _i34;
import 'domain/error/error_handler.dart' as _i28;
import 'domain/model/operation/operation_type.dart' as _i10;
import 'domain/model/operation/pin_change_state.dart' as _i9;
import 'domain/model/operation/pin_enrollment_state.dart' as _i8;
import 'domain/model/operation/user_interaction_operation_state.dart' as _i6;
import 'domain/repository/deep_link_repository.dart' as _i14;
import 'domain/repository/login_repository.dart' as _i18;
import 'domain/repository/state_repository.dart' as _i21;
import 'domain/selector/account_selector.dart' as _i43;
import 'domain/selector/authenticator_selector.dart' as _i44;
import 'domain/usecase/auth_cloud_api_register_usecase.dart' as _i60;
import 'domain/usecase/authenticate_usecase.dart' as _i62;
import 'domain/usecase/authenticators_usecase.dart' as _i63;
import 'domain/usecase/biometric_listen_for_os_credentials_usecase.dart' as _i24;
import 'domain/usecase/cancel_pin_operation_usecase.dart' as _i25;
import 'domain/usecase/cancel_user_interaction_operation_usecase.dart' as _i26;
import 'domain/usecase/change_device_information_usecase.dart' as _i64;
import 'domain/usecase/change_pin_usecase.dart' as _i65;
import 'domain/usecase/create_device_information_usecase.dart' as _i12;
import 'domain/usecase/deregister_all_usecase.dart' as _i48;
import 'domain/usecase/deregister_usecase.dart' as _i49;
import 'domain/usecase/device_information_usecase.dart' as _i50;
import 'domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart' as _i29;
import 'domain/usecase/login_usecase.dart' as _i20;
import 'domain/usecase/oob_payload_decode_usecase.dart' as _i52;
import 'domain/usecase/oob_process_usecase.dart' as _i53;
import 'domain/usecase/pause_listening_usecase.dart' as _i32;
import 'domain/usecase/provided_pins_usecase.dart' as _i36;
import 'domain/usecase/registered_accounts_usecase.dart' as _i56;
import 'domain/usecase/registration_usecase.dart' as _i57;
import 'domain/usecase/reset_user_interaction_state_usecase.dart' as _i37;
import 'domain/usecase/resume_listening_usecase.dart' as _i38;
import 'domain/usecase/select_account_usecase.dart' as _i39;
import 'domain/usecase/select_authenticator_usecase.dart' as _i40;
import 'domain/usecase/set_pin_usecase.dart' as _i41;
import 'domain/usecase/verify_pin_usecase.dart' as _i23;
import 'domain/validation/account_validator.dart' as _i3;
import 'domain/verifier/biometric_user_verifier.dart' as _i46;
import 'domain/verifier/fingerprint_user_verifier.dart' as _i31;
import 'domain/verifier/pin_user_verifier.dart' as _i35;
import 'navigation/app_navigation.dart' as _i4;
import 'navigation/global_navigation_manager.dart' as _i16;
import 'ui/app_state/app_bloc.dart' as _i69;
import 'ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart' as _i61;
import 'ui/screens/change_device_information/change_device_information_bloc.dart' as _i70;
import 'ui/screens/home/home_bloc.dart' as _i66;
import 'ui/screens/legacy_login/legacy_login_bloc.dart' as _i67;
import 'ui/screens/pin/pin_bloc.dart' as _i54;
import 'ui/screens/read_qr_code/read_qr_code_bloc.dart' as _i55;
import 'ui/screens/result/result_bloc.dart' as _i58;
import 'ui/screens/select_account/select_account_bloc.dart' as _i68;
import 'ui/screens/select_authenticator/select_authenticator_bloc.dart' as _i59;
import 'ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart' as _i42;

const String _authenticationCloud = 'authenticationCloud';
const String _identitySuite = 'identitySuite';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AccountValidator>(() => _i3.AccountValidatorImpl());
  gh.singleton<_i4.AppNavigation>(_i4.AppNavigation());
  gh.singleton<_i5.Cache<_i6.UserInteractionOperationState>>(_i7.UserInteractionOperationStateCacheImpl());
  gh.singleton<_i5.Cache<_i8.EnrollPinState>>(_i7.EnrollPinStateCacheImpl());
  gh.singleton<_i5.Cache<_i9.PinChangeState>>(_i7.ChangePinStateCacheImpl());
  gh.singleton<_i5.Cache<_i10.OperationType>>(_i7.OperationTypeCacheImpl());
  gh.singleton<_i11.ConfigurationLoader>(
    _i11.AuthenticationCloudConfigurationLoader(),
    registerFor: {_authenticationCloud},
  );
  gh.singleton<_i11.ConfigurationLoader>(
    _i11.IdentitySuiteConfigurationLoader(),
    registerFor: {_identitySuite},
  );
  gh.factory<_i12.CreateDeviceInformationUseCase>(() => _i12.CreateDeviceInformationUseCaseImpl());
  gh.singleton<_i13.DeepLinkDataSource>(_i13.DeepLinkDataSourceImpl());
  gh.factory<_i14.DeepLinkRepository>(() => _i15.DeepLinkRepositoryImpl(get<_i13.DeepLinkDataSource>()));
  gh.singleton<_i16.GlobalNavigationManager>(_i16.GlobalNavigationManager());
  gh.factory<_i17.LoginDataSource>(() => _i17.LoginDataSourceImpl());
  gh.factory<_i18.LoginRepository>(() => _i19.LoginRepositoryImpl(get<_i17.LoginDataSource>()));
  gh.factory<_i20.LoginUseCase>(() => _i20.LoginUseCaseImpl(get<_i18.LoginRepository>()));
  gh.factory<_i21.StateRepository<_i10.OperationType>>(
      () => _i22.OperationTypeRepositoryImpl(get<_i5.Cache<_i10.OperationType>>()));
  gh.factory<_i21.StateRepository<_i9.PinChangeState>>(
      () => _i22.ChangePinStateRepositoryImpl(get<_i5.Cache<_i9.PinChangeState>>()));
  gh.factory<_i21.StateRepository<_i8.EnrollPinState>>(
      () => _i22.EnrollPinStateRepositoryImpl(get<_i5.Cache<_i8.EnrollPinState>>()));
  gh.factory<_i21.StateRepository<_i6.UserInteractionOperationState>>(
      () => _i22.UserInteractionOperationStateRepositoryImpl(get<_i5.Cache<_i6.UserInteractionOperationState>>()));
  gh.factory<_i23.VerifyPinUseCase>(
      () => _i23.VerifyPinUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i24.BiometricListenForOsCredentialsUseCase>(() =>
      _i24.BiometricListenForOsCredentialsUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i25.CancelPinOperationUseCase>(() => _i25.CancelPinOperationUseCaseImpl(
        get<_i21.StateRepository<_i8.EnrollPinState>>(),
        get<_i21.StateRepository<_i9.PinChangeState>>(),
      ));
  gh.factory<_i26.CancelUserInteractionOperationUseCase>(() =>
      _i26.CancelUserInteractionOperationUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.singleton<_i27.DomainBloc>(_i27.DomainBloc(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i28.ErrorHandler>(() => _i28.ErrorHandlerImpl(
        get<_i16.GlobalNavigationManager>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
      ));
  gh.factory<_i29.FingerPrintListenForOsCredentialsUseCase>(() => _i29.FingerPrintListenForOsCredentialsUseCaseImpl(
      get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i30.FingerprintUserVerifier>(() => _i31.FingerprintUserVerifierImpl(
        get<_i27.DomainBloc>(),
        get<_i28.ErrorHandler>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
      ));
  gh.factory<_i32.PauseListeningUseCase>(
      () => _i32.PauseListeningUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i30.PinChanger>(() => _i33.PinChangerImpl(
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i9.PinChangeState>>(),
      ));
  gh.factory<_i30.PinEnroller>(() => _i34.PinEnrollerImpl(
        get<_i21.StateRepository<_i8.EnrollPinState>>(),
        get<_i27.DomainBloc>(),
      ));
  gh.factory<_i30.PinUserVerifier>(() => _i35.PinUserVerifierImpl(
        get<_i27.DomainBloc>(),
        get<_i28.ErrorHandler>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
      ));
  gh.factory<_i36.ProvidedPinsUseCase>(() => _i36.ProvidedPinsUseCaseImpl(
        get<_i21.StateRepository<_i9.PinChangeState>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i37.ResetUserInteractionStateUseCase>(
      () => _i37.ResetUserInteractionStateUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i38.ResumeListeningUseCase>(
      () => _i38.ResumeListeningUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i39.SelectAccountUseCase>(
      () => _i39.SelectAccountUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i40.SelectAuthenticatorUseCase>(
      () => _i40.SelectAuthenticatorUseCaseImpl(get<_i21.StateRepository<_i6.UserInteractionOperationState>>()));
  gh.factory<_i41.SetPinUseCase>(() => _i41.SetPinUseCaseImpl(get<_i21.StateRepository<_i8.EnrollPinState>>()));
  gh.factory<_i42.TransactionConfirmationBloc>(() => _i42.TransactionConfirmationBloc(
        get<_i28.ErrorHandler>(),
        get<_i39.SelectAccountUseCase>(),
        get<_i26.CancelUserInteractionOperationUseCase>(),
        get<_i16.GlobalNavigationManager>(),
      ));
  gh.factory<_i30.AccountSelector>(() => _i43.AccountSelectorImpl(
        get<_i27.DomainBloc>(),
        get<_i28.ErrorHandler>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
        get<_i3.AccountValidator>(),
      ));
  gh.factory<_i30.AuthenticatorSelector>(() => _i44.AuthenticatorSelectorImpl(
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
      ));
  gh.factory<_i45.BatchCall>(() => _i45.BatchCallImpl(
        get<_i27.DomainBloc>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i30.BiometricUserVerifier>(() => _i46.BiometricUserVerifierImpl(
        get<_i27.DomainBloc>(),
        get<_i28.ErrorHandler>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
      ));
  gh.factory<_i47.ClientProvider>(() => _i47.ClientProviderImpl(
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i48.DeregisterAllUseCase>(() => _i48.DeregisterAllUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
      ));
  gh.factory<_i49.DeregisterUseCase>(() => _i49.DeregisterUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
      ));
  gh.factory<_i50.DeviceInformationUseCase>(() => _i50.DeviceInformationUseCaseImpl(get<_i47.ClientProvider>()));
  gh.singleton<_i51.LocalDataBloc>(_i51.LocalDataBloc(
    get<_i47.ClientProvider>(),
    get<_i28.ErrorHandler>(),
  ));
  gh.factory<_i52.OobPayloadDecodeUseCase>(() => _i52.OobPayloadDecodeUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i53.OobProcessUseCase>(() => _i53.OobProcessUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i12.CreateDeviceInformationUseCase>(),
        get<_i52.OobPayloadDecodeUseCase>(),
        get<_i30.AccountSelector>(),
        get<_i30.AuthenticatorSelector>(),
        get<_i30.PinEnroller>(),
        get<_i30.BiometricUserVerifier>(),
        get<_i30.PinUserVerifier>(),
        get<_i30.FingerprintUserVerifier>(),
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i54.PinBloc>(() => _i54.PinBloc(
        get<_i27.DomainBloc>(),
        get<_i25.CancelPinOperationUseCase>(),
        get<_i36.ProvidedPinsUseCase>(),
        get<_i26.CancelUserInteractionOperationUseCase>(),
        get<_i41.SetPinUseCase>(),
        get<_i23.VerifyPinUseCase>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i55.ReadQrCodeBloc>(() => _i55.ReadQrCodeBloc(
        get<_i53.OobProcessUseCase>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i56.RegisteredAccountsUseCase>(() => _i56.RegisteredAccountsUseCaseImpl(get<_i47.ClientProvider>()));
  gh.factory<_i57.RegistrationUseCase>(() => _i57.RegistrationUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i12.CreateDeviceInformationUseCase>(),
        get<_i30.AuthenticatorSelector>(),
        get<_i30.PinEnroller>(),
        get<_i30.BiometricUserVerifier>(),
        get<_i30.FingerprintUserVerifier>(),
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i58.ResultBloc>(() => _i58.ResultBloc(
        get<_i16.GlobalNavigationManager>(),
        get<_i51.LocalDataBloc>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
      ));
  gh.factory<_i59.SelectAuthenticatorBloc>(() => _i59.SelectAuthenticatorBloc(
        get<_i40.SelectAuthenticatorUseCase>(),
        get<_i16.GlobalNavigationManager>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i60.AuthCloudApiRegisterUseCase>(() => _i60.AuthCloudApiRegisterUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i12.CreateDeviceInformationUseCase>(),
        get<_i30.AuthenticatorSelector>(),
        get<_i30.PinEnroller>(),
        get<_i30.BiometricUserVerifier>(),
        get<_i30.FingerprintUserVerifier>(),
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i6.UserInteractionOperationState>>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i61.AuthCloudApiRegistrationBloc>(() => _i61.AuthCloudApiRegistrationBloc(
        get<_i16.GlobalNavigationManager>(),
        get<_i60.AuthCloudApiRegisterUseCase>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i62.AuthenticateUseCase>(() => _i62.AuthenticateUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i30.AuthenticatorSelector>(),
        get<_i30.BiometricUserVerifier>(),
        get<_i30.FingerprintUserVerifier>(),
        get<_i30.PinUserVerifier>(),
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i63.AuthenticatorsUseCase>(() => _i63.AuthenticatorsUseCaseImpl(get<_i47.ClientProvider>()));
  gh.factory<_i64.ChangeDeviceInformationUseCase>(() => _i64.ChangeDeviceInformationUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i27.DomainBloc>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i65.ChangePinUseCase>(() => _i65.ChangePinUseCaseImpl(
        get<_i47.ClientProvider>(),
        get<_i30.PinChanger>(),
        get<_i27.DomainBloc>(),
        get<_i21.StateRepository<_i10.OperationType>>(),
        get<_i21.StateRepository<_i9.PinChangeState>>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i66.HomeBloc>(() => _i66.HomeBloc(
        get<_i14.DeepLinkRepository>(),
        get<_i11.ConfigurationLoader>(),
        get<_i47.ClientProvider>(),
        get<_i53.OobProcessUseCase>(),
        get<_i56.RegisteredAccountsUseCase>(),
        get<_i48.DeregisterAllUseCase>(),
        get<_i63.AuthenticatorsUseCase>(),
        get<_i65.ChangePinUseCase>(),
        get<_i51.LocalDataBloc>(),
        get<_i28.ErrorHandler>(),
        get<_i16.GlobalNavigationManager>(),
      ));
  gh.factory<_i67.LegacyLoginBloc>(() => _i67.LegacyLoginBloc(
        get<_i11.ConfigurationLoader>(),
        get<_i20.LoginUseCase>(),
        get<_i57.RegistrationUseCase>(),
        get<_i28.ErrorHandler>(),
      ));
  gh.factory<_i68.SelectAccountBloc>(() => _i68.SelectAccountBloc(
        get<_i62.AuthenticateUseCase>(),
        get<_i39.SelectAccountUseCase>(),
        get<_i65.ChangePinUseCase>(),
        get<_i28.ErrorHandler>(),
        get<_i16.GlobalNavigationManager>(),
      ));
  gh.singleton<_i69.AppBloc>(_i69.AppBloc(
    get<_i29.FingerPrintListenForOsCredentialsUseCase>(),
    get<_i24.BiometricListenForOsCredentialsUseCase>(),
    get<_i63.AuthenticatorsUseCase>(),
    get<_i49.DeregisterUseCase>(),
    get<_i11.ConfigurationLoader>(),
    get<_i28.ErrorHandler>(),
    get<_i27.DomainBloc>(),
    get<_i16.GlobalNavigationManager>(),
  ));
  gh.factory<_i70.ChangeDeviceInformationBloc>(() => _i70.ChangeDeviceInformationBloc(
        get<_i16.GlobalNavigationManager>(),
        get<_i64.ChangeDeviceInformationUseCase>(),
        get<_i50.DeviceInformationUseCase>(),
        get<_i28.ErrorHandler>(),
      ));
  return get;
}
