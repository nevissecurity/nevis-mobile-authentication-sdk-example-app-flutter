// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart'
    as _i31;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart'
    as _i11;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/cache/cache.dart'
    as _i5;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/cache/state_cache.dart'
    as _i7;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/datasource/deep_link/deep_link_datasource.dart'
    as _i13;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/datasource/login/login_datasource.dart'
    as _i17;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/repository/deep_link_repository_impl.dart'
    as _i15;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/repository/login_repository_impl.dart'
    as _i19;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/repository/state_repository_impl.dart'
    as _i22;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/batch_call/batch_call.dart'
    as _i47;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart'
    as _i28;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_bloc.dart'
    as _i55;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart'
    as _i49;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart'
    as _i29;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/account_selector.dart'
    as _i44;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/authentication_authenticator_selector.dart'
    as _i45;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/biometric_user_verifier.dart'
    as _i48;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/device_passcode_user_verifier.dart'
    as _i54;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/fingerprint_user_verifier.dart'
    as _i32;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/pin_changer.dart'
    as _i34;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/pin_enroller.dart'
    as _i35;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/pin_user_verifier.dart'
    as _i36;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/registration_authenticator_selector.dart'
    as _i46;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart'
    as _i6;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart'
    as _i8;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart'
    as _i9;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart'
    as _i10;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/deep_link_repository.dart'
    as _i14;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/login_repository.dart'
    as _i18;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart'
    as _i21;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/auth_cloud_api_register_usecase.dart'
    as _i64;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticate_usecase.dart'
    as _i66;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticators_usecase.dart'
    as _i67;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/biometric_listen_for_os_credentials_usecase.dart'
    as _i24;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_pin_operation_usecase.dart'
    as _i25;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_user_interaction_operation_usecase.dart'
    as _i26;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_device_information_usecase.dart'
    as _i68;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_pin_usecase.dart'
    as _i69;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/create_device_information_usecase.dart'
    as _i12;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/delete_authenticators_usecase.dart'
    as _i50;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_all_usecase.dart'
    as _i51;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_usecase.dart'
    as _i52;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/device_information_usecase.dart'
    as _i53;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/device_passcode_listen_for_os_credentials_usecase.dart'
    as _i27;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart'
    as _i30;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/login_usecase.dart'
    as _i20;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_payload_decode_usecase.dart'
    as _i56;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_process_usecase.dart'
    as _i57;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/pause_listening_usecase.dart'
    as _i33;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/provided_pins_usecase.dart'
    as _i37;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registered_accounts_usecase.dart'
    as _i60;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registration_usecase.dart'
    as _i61;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/reset_user_interaction_state_usecase.dart'
    as _i38;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/resume_listening_usecase.dart'
    as _i39;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_account_usecase.dart'
    as _i40;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_authenticator_usecase.dart'
    as _i41;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/set_pin_usecase.dart'
    as _i42;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/verify_pin_usecase.dart'
    as _i23;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/validation/account_validator.dart'
    as _i3;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/app_navigation.dart'
    as _i4;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart'
    as _i16;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_bloc.dart'
    as _i73;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart'
    as _i65;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_bloc.dart'
    as _i74;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_bloc.dart'
    as _i70;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_bloc.dart'
    as _i71;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_bloc.dart'
    as _i58;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_bloc.dart'
    as _i59;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_bloc.dart'
    as _i62;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_bloc.dart'
    as _i72;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_bloc.dart'
    as _i63;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart'
    as _i43;

const String _authenticationCloud = 'authenticationCloud';
const String _identitySuite = 'identitySuite';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
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
  gh.factory<_i3.AccountValidator>(() => _i3.AccountValidatorImpl());
  gh.singleton<_i4.AppNavigation>(_i4.AppNavigation());
  gh.singleton<_i5.Cache<_i6.OperationType>>(_i7.OperationTypeCacheImpl());
  gh.singleton<_i5.Cache<_i8.PinChangeState>>(_i7.ChangePinStateCacheImpl());
  gh.singleton<_i5.Cache<_i9.EnrollPinState>>(_i7.EnrollPinStateCacheImpl());
  gh.singleton<_i5.Cache<_i10.UserInteractionOperationState>>(
      _i7.UserInteractionOperationStateCacheImpl());
  gh.singleton<_i11.ConfigurationLoader>(
    _i11.IdentitySuiteConfigurationLoader(),
    registerFor: {_identitySuite},
  );
  gh.singleton<_i11.ConfigurationLoader>(
    _i11.AuthenticationCloudConfigurationLoader(),
    registerFor: {_authenticationCloud},
  );
  gh.factory<_i12.CreateDeviceInformationUseCase>(
      () => _i12.CreateDeviceInformationUseCaseImpl());
  gh.singleton<_i13.DeepLinkDataSource>(_i13.DeepLinkDataSourceImpl());
  gh.factory<_i14.DeepLinkRepository>(
      () => _i15.DeepLinkRepositoryImpl(gh<_i13.DeepLinkDataSource>()));
  gh.singleton<_i16.GlobalNavigationManager>(_i16.GlobalNavigationManager());
  gh.factory<_i17.LoginDataSource>(() => _i17.LoginDataSourceImpl());
  gh.factory<_i18.LoginRepository>(
      () => _i19.LoginRepositoryImpl(gh<_i17.LoginDataSource>()));
  gh.factory<_i20.LoginUseCase>(
      () => _i20.LoginUseCaseImpl(gh<_i18.LoginRepository>()));
  gh.factory<_i21.StateRepository<_i6.OperationType>>(() =>
      _i22.OperationTypeRepositoryImpl(gh<_i5.Cache<_i6.OperationType>>()));
  gh.factory<_i21.StateRepository<_i8.PinChangeState>>(() =>
      _i22.ChangePinStateRepositoryImpl(gh<_i5.Cache<_i8.PinChangeState>>()));
  gh.factory<_i21.StateRepository<_i9.EnrollPinState>>(() =>
      _i22.EnrollPinStateRepositoryImpl(gh<_i5.Cache<_i9.EnrollPinState>>()));
  gh.factory<_i21.StateRepository<_i10.UserInteractionOperationState>>(() =>
      _i22.UserInteractionOperationStateRepositoryImpl(
          gh<_i5.Cache<_i10.UserInteractionOperationState>>()));
  gh.factory<_i23.VerifyPinUseCase>(() => _i23.VerifyPinUseCaseImpl(
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i24.BiometricListenForOsCredentialsUseCase>(() =>
      _i24.BiometricListenForOsCredentialsUseCaseImpl(
          gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i25.CancelPinOperationUseCase>(
      () => _i25.CancelPinOperationUseCaseImpl(
            gh<_i21.StateRepository<_i9.EnrollPinState>>(),
            gh<_i21.StateRepository<_i8.PinChangeState>>(),
          ));
  gh.factory<_i26.CancelUserInteractionOperationUseCase>(() =>
      _i26.CancelUserInteractionOperationUseCaseImpl(
          gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i27.DevicePasscodeListenForOsCredentialsUseCase>(() =>
      _i27.DevicePasscodeListenForOsCredentialsUseCaseImpl(
          gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.singleton<_i28.DomainBloc>(_i28.DomainBloc(
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i29.ErrorHandler>(() => _i29.ErrorHandlerImpl(
        gh<_i16.GlobalNavigationManager>(),
        gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
      ));
  gh.factory<_i30.FingerPrintListenForOsCredentialsUseCase>(() =>
      _i30.FingerPrintListenForOsCredentialsUseCaseImpl(
          gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i31.FingerprintUserVerifier>(
      () => _i32.FingerprintUserVerifierImpl(
            gh<_i28.DomainBloc>(),
            gh<_i29.ErrorHandler>(),
            gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
          ));
  gh.factory<_i33.PauseListeningUseCase>(() => _i33.PauseListeningUseCaseImpl(
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i31.PinChanger>(() => _i34.PinChangerImpl(
        gh<_i28.DomainBloc>(),
        gh<_i21.StateRepository<_i8.PinChangeState>>(),
      ));
  gh.factory<_i31.PinEnroller>(() => _i35.PinEnrollerImpl(
        gh<_i21.StateRepository<_i9.EnrollPinState>>(),
        gh<_i28.DomainBloc>(),
      ));
  gh.factory<_i31.PinUserVerifier>(() => _i36.PinUserVerifierImpl(
        gh<_i28.DomainBloc>(),
        gh<_i29.ErrorHandler>(),
        gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
      ));
  gh.factory<_i37.ProvidedPinsUseCase>(() => _i37.ProvidedPinsUseCaseImpl(
        gh<_i21.StateRepository<_i8.PinChangeState>>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i38.ResetUserInteractionStateUseCase>(() =>
      _i38.ResetUserInteractionStateUseCaseImpl(
          gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i39.ResumeListeningUseCase>(() => _i39.ResumeListeningUseCaseImpl(
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i40.SelectAccountUseCase>(() => _i40.SelectAccountUseCaseImpl(
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i41.SelectAuthenticatorUseCase>(() =>
      _i41.SelectAuthenticatorUseCaseImpl(
          gh<_i21.StateRepository<_i10.UserInteractionOperationState>>()));
  gh.factory<_i42.SetPinUseCase>(() =>
      _i42.SetPinUseCaseImpl(gh<_i21.StateRepository<_i9.EnrollPinState>>()));
  gh.factory<_i43.TransactionConfirmationBloc>(
      () => _i43.TransactionConfirmationBloc(
            gh<_i29.ErrorHandler>(),
            gh<_i40.SelectAccountUseCase>(),
            gh<_i26.CancelUserInteractionOperationUseCase>(),
            gh<_i16.GlobalNavigationManager>(),
          ));
  gh.factory<_i31.AccountSelector>(() => _i44.AccountSelectorImpl(
        gh<_i28.DomainBloc>(),
        gh<_i29.ErrorHandler>(),
        gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
        gh<_i3.AccountValidator>(),
      ));
  gh.factory<_i31.AuthenticatorSelector>(
    () => _i45.AuthenticationAuthenticatorSelectorImpl(
      gh<_i28.DomainBloc>(),
      gh<_i11.ConfigurationLoader>(),
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_auth',
  );
  gh.factory<_i31.AuthenticatorSelector>(
    () => _i46.RegistrationAuthenticatorSelectorImpl(
      gh<_i28.DomainBloc>(),
      gh<_i11.ConfigurationLoader>(),
      gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_reg',
  );
  gh.factory<_i47.BatchCall>(() => _i47.BatchCallImpl(
        gh<_i28.DomainBloc>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i31.BiometricUserVerifier>(() => _i48.BiometricUserVerifierImpl(
        gh<_i28.DomainBloc>(),
        gh<_i29.ErrorHandler>(),
        gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
      ));
  gh.factory<_i49.ClientProvider>(() => _i49.ClientProviderImpl(
        gh<_i21.StateRepository<_i6.OperationType>>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i50.DeleteAuthenticatorsUseCase>(
      () => _i50.DeleteAuthenticatorsUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i21.StateRepository<_i6.OperationType>>(),
          ));
  gh.factory<_i51.DeregisterAllUseCase>(() => _i51.DeregisterAllUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i52.DeregisterUseCase>(() => _i52.DeregisterUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i53.DeviceInformationUseCase>(
      () => _i53.DeviceInformationUseCaseImpl(gh<_i49.ClientProvider>()));
  gh.factory<_i31.DevicePasscodeUserVerifier>(
      () => _i54.DevicePasscodeUserVerifierImpl(
            gh<_i28.DomainBloc>(),
            gh<_i29.ErrorHandler>(),
            gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
          ));
  gh.singleton<_i55.LocalDataBloc>(_i55.LocalDataBloc(
    gh<_i49.ClientProvider>(),
    gh<_i29.ErrorHandler>(),
  ));
  gh.factory<_i56.OobPayloadDecodeUseCase>(
      () => _i56.OobPayloadDecodeUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i21.StateRepository<_i6.OperationType>>(),
            gh<_i29.ErrorHandler>(),
          ));
  gh.factory<_i57.OobProcessUseCase>(() => _i57.OobProcessUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i12.CreateDeviceInformationUseCase>(),
        gh<_i56.OobPayloadDecodeUseCase>(),
        gh<_i31.AccountSelector>(),
        gh<_i31.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i31.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i31.PinEnroller>(),
        gh<_i31.BiometricUserVerifier>(),
        gh<_i31.DevicePasscodeUserVerifier>(),
        gh<_i31.PinUserVerifier>(),
        gh<_i31.FingerprintUserVerifier>(),
        gh<_i28.DomainBloc>(),
        gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i58.PinBloc>(() => _i58.PinBloc(
        gh<_i28.DomainBloc>(),
        gh<_i25.CancelPinOperationUseCase>(),
        gh<_i37.ProvidedPinsUseCase>(),
        gh<_i26.CancelUserInteractionOperationUseCase>(),
        gh<_i42.SetPinUseCase>(),
        gh<_i23.VerifyPinUseCase>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i59.ReadQrCodeBloc>(() => _i59.ReadQrCodeBloc(
        gh<_i57.OobProcessUseCase>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i60.RegisteredAccountsUseCase>(
      () => _i60.RegisteredAccountsUseCaseImpl(gh<_i49.ClientProvider>()));
  gh.factory<_i61.RegistrationUseCase>(() => _i61.RegistrationUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i12.CreateDeviceInformationUseCase>(),
        gh<_i31.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i31.PinEnroller>(),
        gh<_i31.BiometricUserVerifier>(),
        gh<_i31.DevicePasscodeUserVerifier>(),
        gh<_i31.FingerprintUserVerifier>(),
        gh<_i28.DomainBloc>(),
        gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i62.ResultBloc>(() => _i62.ResultBloc(
        gh<_i16.GlobalNavigationManager>(),
        gh<_i55.LocalDataBloc>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i63.SelectAuthenticatorBloc>(() => _i63.SelectAuthenticatorBloc(
        gh<_i41.SelectAuthenticatorUseCase>(),
        gh<_i16.GlobalNavigationManager>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i64.AuthCloudApiRegisterUseCase>(
      () => _i64.AuthCloudApiRegisterUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i12.CreateDeviceInformationUseCase>(),
            gh<_i31.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
            gh<_i31.PinEnroller>(),
            gh<_i31.BiometricUserVerifier>(),
            gh<_i31.DevicePasscodeUserVerifier>(),
            gh<_i31.FingerprintUserVerifier>(),
            gh<_i28.DomainBloc>(),
            gh<_i21.StateRepository<_i10.UserInteractionOperationState>>(),
            gh<_i21.StateRepository<_i6.OperationType>>(),
            gh<_i29.ErrorHandler>(),
          ));
  gh.factory<_i65.AuthCloudApiRegistrationBloc>(
      () => _i65.AuthCloudApiRegistrationBloc(
            gh<_i16.GlobalNavigationManager>(),
            gh<_i64.AuthCloudApiRegisterUseCase>(),
            gh<_i29.ErrorHandler>(),
          ));
  gh.factory<_i66.AuthenticateUseCase>(() => _i66.AuthenticateUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i31.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i31.BiometricUserVerifier>(),
        gh<_i31.DevicePasscodeUserVerifier>(),
        gh<_i31.FingerprintUserVerifier>(),
        gh<_i31.PinUserVerifier>(),
        gh<_i28.DomainBloc>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i67.AuthenticatorsUseCase>(
      () => _i67.AuthenticatorsUseCaseImpl(gh<_i49.ClientProvider>()));
  gh.factory<_i68.ChangeDeviceInformationUseCase>(
      () => _i68.ChangeDeviceInformationUseCaseImpl(
            gh<_i49.ClientProvider>(),
            gh<_i21.StateRepository<_i6.OperationType>>(),
            gh<_i28.DomainBloc>(),
            gh<_i29.ErrorHandler>(),
          ));
  gh.factory<_i69.ChangePinUseCase>(() => _i69.ChangePinUseCaseImpl(
        gh<_i49.ClientProvider>(),
        gh<_i31.PinChanger>(),
        gh<_i28.DomainBloc>(),
        gh<_i21.StateRepository<_i6.OperationType>>(),
        gh<_i21.StateRepository<_i8.PinChangeState>>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i70.HomeBloc>(() => _i70.HomeBloc(
        gh<_i14.DeepLinkRepository>(),
        gh<_i11.ConfigurationLoader>(),
        gh<_i49.ClientProvider>(),
        gh<_i57.OobProcessUseCase>(),
        gh<_i60.RegisteredAccountsUseCase>(),
        gh<_i51.DeregisterAllUseCase>(),
        gh<_i67.AuthenticatorsUseCase>(),
        gh<_i69.ChangePinUseCase>(),
        gh<_i50.DeleteAuthenticatorsUseCase>(),
        gh<_i55.LocalDataBloc>(),
        gh<_i29.ErrorHandler>(),
        gh<_i16.GlobalNavigationManager>(),
      ));
  gh.factory<_i71.LegacyLoginBloc>(() => _i71.LegacyLoginBloc(
        gh<_i11.ConfigurationLoader>(),
        gh<_i20.LoginUseCase>(),
        gh<_i61.RegistrationUseCase>(),
        gh<_i29.ErrorHandler>(),
      ));
  gh.factory<_i72.SelectAccountBloc>(() => _i72.SelectAccountBloc(
        gh<_i66.AuthenticateUseCase>(),
        gh<_i40.SelectAccountUseCase>(),
        gh<_i69.ChangePinUseCase>(),
        gh<_i29.ErrorHandler>(),
        gh<_i16.GlobalNavigationManager>(),
      ));
  gh.singleton<_i73.AppBloc>(_i73.AppBloc(
    gh<_i30.FingerPrintListenForOsCredentialsUseCase>(),
    gh<_i24.BiometricListenForOsCredentialsUseCase>(),
    gh<_i27.DevicePasscodeListenForOsCredentialsUseCase>(),
    gh<_i67.AuthenticatorsUseCase>(),
    gh<_i52.DeregisterUseCase>(),
    gh<_i11.ConfigurationLoader>(),
    gh<_i29.ErrorHandler>(),
    gh<_i28.DomainBloc>(),
    gh<_i16.GlobalNavigationManager>(),
  ));
  gh.factory<_i74.ChangeDeviceInformationBloc>(
      () => _i74.ChangeDeviceInformationBloc(
            gh<_i16.GlobalNavigationManager>(),
            gh<_i68.ChangeDeviceInformationUseCase>(),
            gh<_i53.DeviceInformationUseCase>(),
            gh<_i29.ErrorHandler>(),
          ));
  return getIt;
}
