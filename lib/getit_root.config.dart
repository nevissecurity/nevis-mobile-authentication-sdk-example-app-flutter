// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart'
    as _i30;
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
    as _i45;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart'
    as _i27;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_bloc.dart'
    as _i51;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/changer/pin_changer.dart'
    as _i33;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart'
    as _i47;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/enroller/pin_enroller.dart'
    as _i34;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart'
    as _i28;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart'
    as _i8;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart'
    as _i6;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart'
    as _i10;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart'
    as _i9;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/deep_link_repository.dart'
    as _i14;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/login_repository.dart'
    as _i18;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart'
    as _i21;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/selector/account_selector.dart'
    as _i43;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/selector/authenticator_selector.dart'
    as _i44;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/auth_cloud_api_register_usecase.dart'
    as _i60;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticate_usecase.dart'
    as _i62;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/authenticators_usecase.dart'
    as _i63;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/biometric_listen_for_os_credentials_usecase.dart'
    as _i24;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_pin_operation_usecase.dart'
    as _i25;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/cancel_user_interaction_operation_usecase.dart'
    as _i26;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_device_information_usecase.dart'
    as _i64;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_pin_usecase.dart'
    as _i65;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/create_device_information_usecase.dart'
    as _i12;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_all_usecase.dart'
    as _i48;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/deregister_usecase.dart'
    as _i49;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/device_information_usecase.dart'
    as _i50;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart'
    as _i29;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/login_usecase.dart'
    as _i20;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_payload_decode_usecase.dart'
    as _i52;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_process_usecase.dart'
    as _i53;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/pause_listening_usecase.dart'
    as _i32;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/provided_pins_usecase.dart'
    as _i36;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registered_accounts_usecase.dart'
    as _i56;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/registration_usecase.dart'
    as _i57;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/reset_user_interaction_state_usecase.dart'
    as _i37;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/resume_listening_usecase.dart'
    as _i38;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_account_usecase.dart'
    as _i39;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/select_authenticator_usecase.dart'
    as _i40;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/set_pin_usecase.dart'
    as _i41;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/verify_pin_usecase.dart'
    as _i23;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/validation/account_validator.dart'
    as _i3;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/verifier/biometric_user_verifier.dart'
    as _i46;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/verifier/fingerprint_user_verifier.dart'
    as _i31;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/verifier/pin_user_verifier.dart'
    as _i35;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/app_navigation.dart'
    as _i4;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart'
    as _i16;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_bloc.dart'
    as _i69;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart'
    as _i61;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_bloc.dart'
    as _i70;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_bloc.dart'
    as _i66;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_bloc.dart'
    as _i67;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_bloc.dart'
    as _i54;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_bloc.dart'
    as _i55;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_bloc.dart'
    as _i58;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_bloc.dart'
    as _i68;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_bloc.dart'
    as _i59;
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart'
    as _i42;

const String _authenticationCloud = 'authenticationCloud';
const String _identitySuite = 'identitySuite';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
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
  gh.singleton<_i5.Cache<_i6.PinChangeState>>(_i7.ChangePinStateCacheImpl());
  gh.singleton<_i5.Cache<_i8.OperationType>>(_i7.OperationTypeCacheImpl());
  gh.singleton<_i5.Cache<_i9.UserInteractionOperationState>>(
      _i7.UserInteractionOperationStateCacheImpl());
  gh.singleton<_i5.Cache<_i10.EnrollPinState>>(_i7.EnrollPinStateCacheImpl());
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
  gh.factory<_i21.StateRepository<_i8.OperationType>>(() =>
      _i22.OperationTypeRepositoryImpl(gh<_i5.Cache<_i8.OperationType>>()));
  gh.factory<_i21.StateRepository<_i6.PinChangeState>>(() =>
      _i22.ChangePinStateRepositoryImpl(gh<_i5.Cache<_i6.PinChangeState>>()));
  gh.factory<_i21.StateRepository<_i10.EnrollPinState>>(() =>
      _i22.EnrollPinStateRepositoryImpl(gh<_i5.Cache<_i10.EnrollPinState>>()));
  gh.factory<_i21.StateRepository<_i9.UserInteractionOperationState>>(() =>
      _i22.UserInteractionOperationStateRepositoryImpl(
          gh<_i5.Cache<_i9.UserInteractionOperationState>>()));
  gh.factory<_i23.VerifyPinUseCase>(() => _i23.VerifyPinUseCaseImpl(
      gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i24.BiometricListenForOsCredentialsUseCase>(() =>
      _i24.BiometricListenForOsCredentialsUseCaseImpl(
          gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i25.CancelPinOperationUseCase>(
      () => _i25.CancelPinOperationUseCaseImpl(
            gh<_i21.StateRepository<_i10.EnrollPinState>>(),
            gh<_i21.StateRepository<_i6.PinChangeState>>(),
          ));
  gh.factory<_i26.CancelUserInteractionOperationUseCase>(() =>
      _i26.CancelUserInteractionOperationUseCaseImpl(
          gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.singleton<_i27.DomainBloc>(_i27.DomainBloc(
      gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i28.ErrorHandler>(() => _i28.ErrorHandlerImpl(
        gh<_i16.GlobalNavigationManager>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i29.FingerPrintListenForOsCredentialsUseCase>(() =>
      _i29.FingerPrintListenForOsCredentialsUseCaseImpl(
          gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i30.FingerprintUserVerifier>(
      () => _i31.FingerprintUserVerifierImpl(
            gh<_i27.DomainBloc>(),
            gh<_i28.ErrorHandler>(),
            gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i32.PauseListeningUseCase>(() => _i32.PauseListeningUseCaseImpl(
      gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i30.PinChanger>(() => _i33.PinChangerImpl(
        gh<_i27.DomainBloc>(),
        gh<_i21.StateRepository<_i6.PinChangeState>>(),
      ));
  gh.factory<_i30.PinEnroller>(() => _i34.PinEnrollerImpl(
        gh<_i21.StateRepository<_i10.EnrollPinState>>(),
        gh<_i27.DomainBloc>(),
      ));
  gh.factory<_i30.PinUserVerifier>(() => _i35.PinUserVerifierImpl(
        gh<_i27.DomainBloc>(),
        gh<_i28.ErrorHandler>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i36.ProvidedPinsUseCase>(() => _i36.ProvidedPinsUseCaseImpl(
        gh<_i21.StateRepository<_i6.PinChangeState>>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i37.ResetUserInteractionStateUseCase>(() =>
      _i37.ResetUserInteractionStateUseCaseImpl(
          gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i38.ResumeListeningUseCase>(() => _i38.ResumeListeningUseCaseImpl(
      gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i39.SelectAccountUseCase>(() => _i39.SelectAccountUseCaseImpl(
      gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i40.SelectAuthenticatorUseCase>(() =>
      _i40.SelectAuthenticatorUseCaseImpl(
          gh<_i21.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i41.SetPinUseCase>(() =>
      _i41.SetPinUseCaseImpl(gh<_i21.StateRepository<_i10.EnrollPinState>>()));
  gh.factory<_i42.TransactionConfirmationBloc>(
      () => _i42.TransactionConfirmationBloc(
            gh<_i28.ErrorHandler>(),
            gh<_i39.SelectAccountUseCase>(),
            gh<_i26.CancelUserInteractionOperationUseCase>(),
            gh<_i16.GlobalNavigationManager>(),
          ));
  gh.factory<_i30.AccountSelector>(() => _i43.AccountSelectorImpl(
        gh<_i27.DomainBloc>(),
        gh<_i28.ErrorHandler>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i3.AccountValidator>(),
      ));
  gh.factory<_i30.AuthenticatorSelector>(() => _i44.AuthenticatorSelectorImpl(
        gh<_i27.DomainBloc>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
      ));
  gh.factory<_i45.BatchCall>(() => _i45.BatchCallImpl(
        gh<_i27.DomainBloc>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i30.BiometricUserVerifier>(() => _i46.BiometricUserVerifierImpl(
        gh<_i27.DomainBloc>(),
        gh<_i28.ErrorHandler>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i47.ClientProvider>(() => _i47.ClientProviderImpl(
        gh<_i21.StateRepository<_i8.OperationType>>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i48.DeregisterAllUseCase>(() => _i48.DeregisterAllUseCaseImpl(
        gh<_i47.ClientProvider>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
      ));
  gh.factory<_i49.DeregisterUseCase>(() => _i49.DeregisterUseCaseImpl(
        gh<_i47.ClientProvider>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
      ));
  gh.factory<_i50.DeviceInformationUseCase>(
      () => _i50.DeviceInformationUseCaseImpl(gh<_i47.ClientProvider>()));
  gh.singleton<_i51.LocalDataBloc>(_i51.LocalDataBloc(
    gh<_i47.ClientProvider>(),
    gh<_i28.ErrorHandler>(),
  ));
  gh.factory<_i52.OobPayloadDecodeUseCase>(
      () => _i52.OobPayloadDecodeUseCaseImpl(
            gh<_i47.ClientProvider>(),
            gh<_i21.StateRepository<_i8.OperationType>>(),
            gh<_i28.ErrorHandler>(),
          ));
  gh.factory<_i53.OobProcessUseCase>(() => _i53.OobProcessUseCaseImpl(
        gh<_i47.ClientProvider>(),
        gh<_i12.CreateDeviceInformationUseCase>(),
        gh<_i52.OobPayloadDecodeUseCase>(),
        gh<_i30.AccountSelector>(),
        gh<_i30.AuthenticatorSelector>(),
        gh<_i30.PinEnroller>(),
        gh<_i30.BiometricUserVerifier>(),
        gh<_i30.PinUserVerifier>(),
        gh<_i30.FingerprintUserVerifier>(),
        gh<_i27.DomainBloc>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i54.PinBloc>(() => _i54.PinBloc(
        gh<_i27.DomainBloc>(),
        gh<_i25.CancelPinOperationUseCase>(),
        gh<_i36.ProvidedPinsUseCase>(),
        gh<_i26.CancelUserInteractionOperationUseCase>(),
        gh<_i41.SetPinUseCase>(),
        gh<_i23.VerifyPinUseCase>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i55.ReadQrCodeBloc>(() => _i55.ReadQrCodeBloc(
        gh<_i53.OobProcessUseCase>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i56.RegisteredAccountsUseCase>(
      () => _i56.RegisteredAccountsUseCaseImpl(gh<_i47.ClientProvider>()));
  gh.factory<_i57.RegistrationUseCase>(() => _i57.RegistrationUseCaseImpl(
        gh<_i47.ClientProvider>(),
        gh<_i12.CreateDeviceInformationUseCase>(),
        gh<_i30.AuthenticatorSelector>(),
        gh<_i30.PinEnroller>(),
        gh<_i30.BiometricUserVerifier>(),
        gh<_i30.FingerprintUserVerifier>(),
        gh<_i27.DomainBloc>(),
        gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i58.ResultBloc>(() => _i58.ResultBloc(
        gh<_i16.GlobalNavigationManager>(),
        gh<_i51.LocalDataBloc>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
      ));
  gh.factory<_i59.SelectAuthenticatorBloc>(() => _i59.SelectAuthenticatorBloc(
        gh<_i40.SelectAuthenticatorUseCase>(),
        gh<_i16.GlobalNavigationManager>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i60.AuthCloudApiRegisterUseCase>(
      () => _i60.AuthCloudApiRegisterUseCaseImpl(
            gh<_i47.ClientProvider>(),
            gh<_i12.CreateDeviceInformationUseCase>(),
            gh<_i30.AuthenticatorSelector>(),
            gh<_i30.PinEnroller>(),
            gh<_i30.BiometricUserVerifier>(),
            gh<_i30.FingerprintUserVerifier>(),
            gh<_i27.DomainBloc>(),
            gh<_i21.StateRepository<_i9.UserInteractionOperationState>>(),
            gh<_i21.StateRepository<_i8.OperationType>>(),
            gh<_i28.ErrorHandler>(),
          ));
  gh.factory<_i61.AuthCloudApiRegistrationBloc>(
      () => _i61.AuthCloudApiRegistrationBloc(
            gh<_i16.GlobalNavigationManager>(),
            gh<_i60.AuthCloudApiRegisterUseCase>(),
            gh<_i28.ErrorHandler>(),
          ));
  gh.factory<_i62.AuthenticateUseCase>(() => _i62.AuthenticateUseCaseImpl(
        gh<_i47.ClientProvider>(),
        gh<_i30.AuthenticatorSelector>(),
        gh<_i30.BiometricUserVerifier>(),
        gh<_i30.FingerprintUserVerifier>(),
        gh<_i30.PinUserVerifier>(),
        gh<_i27.DomainBloc>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i63.AuthenticatorsUseCase>(
      () => _i63.AuthenticatorsUseCaseImpl(gh<_i47.ClientProvider>()));
  gh.factory<_i64.ChangeDeviceInformationUseCase>(
      () => _i64.ChangeDeviceInformationUseCaseImpl(
            gh<_i47.ClientProvider>(),
            gh<_i21.StateRepository<_i8.OperationType>>(),
            gh<_i27.DomainBloc>(),
            gh<_i28.ErrorHandler>(),
          ));
  gh.factory<_i65.ChangePinUseCase>(() => _i65.ChangePinUseCaseImpl(
        gh<_i47.ClientProvider>(),
        gh<_i30.PinChanger>(),
        gh<_i27.DomainBloc>(),
        gh<_i21.StateRepository<_i8.OperationType>>(),
        gh<_i21.StateRepository<_i6.PinChangeState>>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i66.HomeBloc>(() => _i66.HomeBloc(
        gh<_i14.DeepLinkRepository>(),
        gh<_i11.ConfigurationLoader>(),
        gh<_i47.ClientProvider>(),
        gh<_i53.OobProcessUseCase>(),
        gh<_i56.RegisteredAccountsUseCase>(),
        gh<_i48.DeregisterAllUseCase>(),
        gh<_i63.AuthenticatorsUseCase>(),
        gh<_i65.ChangePinUseCase>(),
        gh<_i51.LocalDataBloc>(),
        gh<_i28.ErrorHandler>(),
        gh<_i16.GlobalNavigationManager>(),
      ));
  gh.factory<_i67.LegacyLoginBloc>(() => _i67.LegacyLoginBloc(
        gh<_i11.ConfigurationLoader>(),
        gh<_i20.LoginUseCase>(),
        gh<_i57.RegistrationUseCase>(),
        gh<_i28.ErrorHandler>(),
      ));
  gh.factory<_i68.SelectAccountBloc>(() => _i68.SelectAccountBloc(
        gh<_i62.AuthenticateUseCase>(),
        gh<_i39.SelectAccountUseCase>(),
        gh<_i65.ChangePinUseCase>(),
        gh<_i28.ErrorHandler>(),
        gh<_i16.GlobalNavigationManager>(),
      ));
  gh.singleton<_i69.AppBloc>(_i69.AppBloc(
    gh<_i29.FingerPrintListenForOsCredentialsUseCase>(),
    gh<_i24.BiometricListenForOsCredentialsUseCase>(),
    gh<_i63.AuthenticatorsUseCase>(),
    gh<_i49.DeregisterUseCase>(),
    gh<_i11.ConfigurationLoader>(),
    gh<_i28.ErrorHandler>(),
    gh<_i27.DomainBloc>(),
    gh<_i16.GlobalNavigationManager>(),
  ));
  gh.factory<_i70.ChangeDeviceInformationBloc>(
      () => _i70.ChangeDeviceInformationBloc(
            gh<_i16.GlobalNavigationManager>(),
            gh<_i64.ChangeDeviceInformationUseCase>(),
            gh<_i50.DeviceInformationUseCase>(),
            gh<_i28.ErrorHandler>(),
          ));
  return getIt;
}
