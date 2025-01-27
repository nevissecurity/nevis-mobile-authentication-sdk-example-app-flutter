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
    as _i15;

import 'configuration/configuration_loader.dart' as _i21;
import 'data/cache/cache.dart' as _i5;
import 'data/cache/state_cache.dart' as _i7;
import 'data/datasource/deep_link/deep_link_datasource.dart' as _i11;
import 'data/datasource/login/login_datasource.dart' as _i8;
import 'data/repository/deep_link_repository_impl.dart' as _i39;
import 'data/repository/login_repository_impl.dart' as _i18;
import 'data/repository/state_repository_impl.dart' as _i13;
import 'domain/batch_call/batch_call.dart' as _i50;
import 'domain/blocs/domain_state/domain_bloc.dart' as _i28;
import 'domain/blocs/local_data/local_data_bloc.dart' as _i63;
import 'domain/client_provider/client_provider.dart' as _i53;
import 'domain/error/error_handler.dart' as _i41;
import 'domain/interaction/account_selector_impl.dart' as _i48;
import 'domain/interaction/authentication_authenticator_selector_impl.dart'
    as _i46;
import 'domain/interaction/biometric_user_verifier_impl.dart' as _i51;
import 'domain/interaction/device_passcode_user_verifier_impl.dart' as _i52;
import 'domain/interaction/fingerprint_user_verifier_impl.dart' as _i59;
import 'domain/interaction/password_changer.dart' as _i32;
import 'domain/interaction/password_enroller.dart' as _i40;
import 'domain/interaction/password_user_verifier.dart' as _i57;
import 'domain/interaction/pin_changer_impl.dart' as _i33;
import 'domain/interaction/pin_enroller_impl.dart' as _i43;
import 'domain/interaction/pin_user_verifier_impl.dart' as _i54;
import 'domain/interaction/registration_authenticator_selector_impl.dart'
    as _i44;
import 'domain/model/operation/operation_type.dart' as _i6;
import 'domain/model/operation/password_change_state.dart' as _i14;
import 'domain/model/operation/password_enrollment_state.dart' as _i10;
import 'domain/model/operation/pin_change_state.dart' as _i20;
import 'domain/model/operation/pin_enrollment_state.dart' as _i23;
import 'domain/model/operation/user_interaction_operation_state.dart' as _i9;
import 'domain/repository/deep_link_repository.dart' as _i38;
import 'domain/repository/login_repository.dart' as _i17;
import 'domain/repository/state_repository.dart' as _i12;
import 'domain/usecase/auth_cloud_api_register_usecase.dart' as _i82;
import 'domain/usecase/authenticate_usecase.dart' as _i68;
import 'domain/usecase/authenticators_usecase.dart' as _i67;
import 'domain/usecase/biometric_listen_for_os_credentials_usecase.dart'
    as _i27;
import 'domain/usecase/cancel_credential_operation_usecase.dart' as _i61;
import 'domain/usecase/cancel_user_interaction_operation_usecase.dart' as _i31;
import 'domain/usecase/change_device_information_usecase.dart' as _i65;
import 'domain/usecase/change_password_usecase.dart' as _i62;
import 'domain/usecase/change_pin_usecase.dart' as _i71;
import 'domain/usecase/create_device_information_usecase.dart' as _i72;
import 'domain/usecase/delete_authenticators_usecase.dart' as _i60;
import 'domain/usecase/deregister_all_usecase.dart' as _i64;
import 'domain/usecase/deregister_usecase.dart' as _i55;
import 'domain/usecase/device_information_usecase.dart' as _i69;
import 'domain/usecase/device_passcode_listen_for_os_credentials_usecase.dart'
    as _i26;
import 'domain/usecase/enroll_credential_usecase.dart' as _i45;
import 'domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart'
    as _i35;
import 'domain/usecase/login_usecase.dart' as _i29;
import 'domain/usecase/oob_payload_decode_usecase.dart' as _i66;
import 'domain/usecase/oob_process_usecase.dart' as _i76;
import 'domain/usecase/pause_listening_usecase.dart' as _i25;
import 'domain/usecase/provided_credentials_usecase.dart' as _i42;
import 'domain/usecase/registered_accounts_usecase.dart' as _i56;
import 'domain/usecase/registration_usecase.dart' as _i73;
import 'domain/usecase/reset_user_interaction_state_usecase.dart' as _i34;
import 'domain/usecase/resume_listening_usecase.dart' as _i36;
import 'domain/usecase/select_account_usecase.dart' as _i24;
import 'domain/usecase/select_authenticator_usecase.dart' as _i37;
import 'domain/usecase/verify_credential_usecase.dart' as _i30;
import 'domain/validation/account_validator.dart' as _i22;
import 'domain/validation/authenticator_validator.dart' as _i19;
import 'domain/validation/password_policy_impl.dart' as _i16;
import 'navigation/app_navigation.dart' as _i4;
import 'navigation/global_navigation_manager.dart' as _i3;
import 'ui/app_state/app_bloc.dart' as _i70;
import 'ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart'
    as _i83;
import 'ui/screens/change_device_information/change_device_information_bloc.dart'
    as _i77;
import 'ui/screens/confirmation/confirmation_bloc.dart' as _i49;
import 'ui/screens/credential/credential_bloc.dart' as _i75;
import 'ui/screens/home/home_bloc.dart' as _i79;
import 'ui/screens/legacy_login/legacy_login_bloc.dart' as _i81;
import 'ui/screens/read_qr_code/read_qr_code_bloc.dart' as _i80;
import 'ui/screens/result/result_bloc.dart' as _i74;
import 'ui/screens/select_account/select_account_bloc.dart' as _i78;
import 'ui/screens/select_authenticator/select_authenticator_bloc.dart' as _i58;
import 'ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart'
    as _i47;

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
  gh.singleton<_i5.Cache<_i10.PasswordEnrollmentState>>(
      () => _i7.PasswordEnrollmentStateCacheImpl());
  gh.singleton<_i11.DeepLinkDataSource>(() => _i11.DeepLinkDataSourceImpl());
  gh.factory<_i12.StateRepository<_i10.PasswordEnrollmentState>>(() =>
      _i13.PasswordEnrollmentStateRepositoryImpl(
          gh<_i5.Cache<_i10.PasswordEnrollmentState>>()));
  gh.singleton<_i5.Cache<_i14.PasswordChangeState>>(
      () => _i7.PasswordChangeStateCacheImpl());
  gh.factory<_i15.PasswordPolicy>(() => _i16.PasswordPolicyImpl());
  gh.factory<_i17.LoginRepository>(
      () => _i18.LoginRepositoryImpl(gh<_i8.LoginDataSource>()));
  gh.factory<_i19.AuthenticatorValidator>(
      () => _i19.AuthenticatorValidatorImpl());
  gh.singleton<_i5.Cache<_i20.PinChangeState>>(
      () => _i7.PinChangeStateCacheImpl());
  gh.singleton<_i21.ConfigurationLoader>(
    () => _i21.AuthenticationCloudConfigurationLoader(),
    registerFor: {_authenticationCloud},
  );
  gh.singleton<_i21.ConfigurationLoader>(
    () => _i21.IdentitySuiteConfigurationLoader(),
    registerFor: {_identitySuite},
  );
  gh.factory<_i12.StateRepository<_i20.PinChangeState>>(() =>
      _i13.PinChangeStateRepositoryImpl(gh<_i5.Cache<_i20.PinChangeState>>()));
  gh.factory<_i22.AccountValidator>(() => _i22.AccountValidatorImpl());
  gh.singleton<_i5.Cache<_i23.PinEnrollmentState>>(
      () => _i7.PinEnrollmentStateCacheImpl());
  gh.factory<_i12.StateRepository<_i14.PasswordChangeState>>(() =>
      _i13.PasswordChangeStateRepositoryImpl(
          gh<_i5.Cache<_i14.PasswordChangeState>>()));
  gh.factory<_i12.StateRepository<_i9.UserInteractionOperationState>>(() =>
      _i13.UserInteractionOperationStateRepositoryImpl(
          gh<_i5.Cache<_i9.UserInteractionOperationState>>()));
  gh.factory<_i24.SelectAccountUseCase>(() => _i24.SelectAccountUseCaseImpl(
      gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i25.PauseListeningUseCase>(() => _i25.PauseListeningUseCaseImpl(
      gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i26.DevicePasscodeListenForOsCredentialsUseCase>(() =>
      _i26.DevicePasscodeListenForOsCredentialsUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i27.BiometricListenForOsCredentialsUseCase>(() =>
      _i27.BiometricListenForOsCredentialsUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i12.StateRepository<_i6.OperationType>>(() =>
      _i13.OperationTypeRepositoryImpl(gh<_i5.Cache<_i6.OperationType>>()));
  gh.singleton<_i28.DomainBloc>(() => _i28.DomainBloc(
      gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i29.LoginUseCase>(
      () => _i29.LoginUseCaseImpl(gh<_i17.LoginRepository>()));
  gh.factory<_i30.VerifyCredentialUseCase>(() =>
      _i30.VerifyCredentialUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i31.CancelUserInteractionOperationUseCase>(() =>
      _i31.CancelUserInteractionOperationUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i15.PasswordChanger>(() => _i32.PasswordChangerImpl(
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i14.PasswordChangeState>>(),
        gh<_i15.PasswordPolicy>(),
      ));
  gh.factory<_i15.PinChanger>(() => _i33.PinChangerImpl(
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i20.PinChangeState>>(),
      ));
  gh.factory<_i34.ResetUserInteractionStateUseCase>(() =>
      _i34.ResetUserInteractionStateUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i35.FingerPrintListenForOsCredentialsUseCase>(() =>
      _i35.FingerPrintListenForOsCredentialsUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i36.ResumeListeningUseCase>(() => _i36.ResumeListeningUseCaseImpl(
      gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i37.SelectAuthenticatorUseCase>(() =>
      _i37.SelectAuthenticatorUseCaseImpl(
          gh<_i12.StateRepository<_i9.UserInteractionOperationState>>()));
  gh.factory<_i38.DeepLinkRepository>(
      () => _i39.DeepLinkRepositoryImpl(gh<_i11.DeepLinkDataSource>()));
  gh.factory<_i15.PasswordEnroller>(() => _i40.PasswordEnrollerImpl(
        gh<_i12.StateRepository<_i10.PasswordEnrollmentState>>(),
        gh<_i28.DomainBloc>(),
        gh<_i15.PasswordPolicy>(),
      ));
  gh.factory<_i12.StateRepository<_i23.PinEnrollmentState>>(() =>
      _i13.PinEnrollmentStateRepositoryImpl(
          gh<_i5.Cache<_i23.PinEnrollmentState>>()));
  gh.factory<_i41.ErrorHandler>(() => _i41.ErrorHandlerImpl(
        gh<_i3.GlobalNavigationManager>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i42.ProvidedCredentialsUseCase>(
      () => _i42.ProvidedCredentialsUseCaseImpl(
            gh<_i12.StateRepository<_i20.PinChangeState>>(),
            gh<_i12.StateRepository<_i14.PasswordChangeState>>(),
          ));
  gh.factory<_i15.PinEnroller>(() => _i43.PinEnrollerImpl(
        gh<_i12.StateRepository<_i23.PinEnrollmentState>>(),
        gh<_i28.DomainBloc>(),
      ));
  gh.factory<_i15.AuthenticatorSelector>(
    () => _i44.RegistrationAuthenticatorSelectorImpl(
      gh<_i28.DomainBloc>(),
      gh<_i21.ConfigurationLoader>(),
      gh<_i19.AuthenticatorValidator>(),
      gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_reg',
  );
  gh.factory<_i45.EnrollCredentialUseCase>(
      () => _i45.EnrollCredentialUseCaseImpl(
            gh<_i12.StateRepository<_i23.PinEnrollmentState>>(),
            gh<_i12.StateRepository<_i10.PasswordEnrollmentState>>(),
          ));
  gh.factory<_i15.AuthenticatorSelector>(
    () => _i46.AuthenticationAuthenticatorSelectorImpl(
      gh<_i28.DomainBloc>(),
      gh<_i21.ConfigurationLoader>(),
      gh<_i19.AuthenticatorValidator>(),
      gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_auth',
  );
  gh.factory<_i47.TransactionConfirmationBloc>(
      () => _i47.TransactionConfirmationBloc(
            gh<_i41.ErrorHandler>(),
            gh<_i24.SelectAccountUseCase>(),
            gh<_i31.CancelUserInteractionOperationUseCase>(),
            gh<_i3.GlobalNavigationManager>(),
          ));
  gh.factory<_i15.AccountSelector>(() => _i48.AccountSelectorImpl(
        gh<_i28.DomainBloc>(),
        gh<_i41.ErrorHandler>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i22.AccountValidator>(),
      ));
  gh.factory<_i49.ConfirmationBloc>(() => _i49.ConfirmationBloc(
        gh<_i27.BiometricListenForOsCredentialsUseCase>(),
        gh<_i35.FingerPrintListenForOsCredentialsUseCase>(),
        gh<_i26.DevicePasscodeListenForOsCredentialsUseCase>(),
        gh<_i31.CancelUserInteractionOperationUseCase>(),
        gh<_i25.PauseListeningUseCase>(),
        gh<_i36.ResumeListeningUseCase>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i50.BatchCall>(() => _i50.BatchCallImpl(
        gh<_i28.DomainBloc>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i15.BiometricUserVerifier>(() => _i51.BiometricUserVerifierImpl(
        gh<_i28.DomainBloc>(),
        gh<_i41.ErrorHandler>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i15.DevicePasscodeUserVerifier>(
      () => _i52.DevicePasscodeUserVerifierImpl(
            gh<_i28.DomainBloc>(),
            gh<_i41.ErrorHandler>(),
            gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i53.ClientProvider>(() => _i53.ClientProviderImpl(
        gh<_i12.StateRepository<_i6.OperationType>>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i15.PinUserVerifier>(() => _i54.PinUserVerifierImpl(
        gh<_i28.DomainBloc>(),
        gh<_i41.ErrorHandler>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i55.DeregisterUseCase>(() => _i55.DeregisterUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i56.RegisteredAccountsUseCase>(
      () => _i56.RegisteredAccountsUseCaseImpl(gh<_i53.ClientProvider>()));
  gh.factory<_i15.PasswordUserVerifier>(() => _i57.PasswordUserVerifierImpl(
        gh<_i28.DomainBloc>(),
        gh<_i41.ErrorHandler>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
      ));
  gh.factory<_i58.SelectAuthenticatorBloc>(() => _i58.SelectAuthenticatorBloc(
        gh<_i37.SelectAuthenticatorUseCase>(),
        gh<_i3.GlobalNavigationManager>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i15.FingerprintUserVerifier>(
      () => _i59.FingerprintUserVerifierImpl(
            gh<_i28.DomainBloc>(),
            gh<_i41.ErrorHandler>(),
            gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
          ));
  gh.factory<_i60.DeleteAuthenticatorsUseCase>(
      () => _i60.DeleteAuthenticatorsUseCaseImpl(
            gh<_i53.ClientProvider>(),
            gh<_i12.StateRepository<_i6.OperationType>>(),
          ));
  gh.factory<_i61.CancelCredentialOperationUseCase>(
      () => _i61.CancelCredentialOperationUseCaseImpl(
            gh<_i12.StateRepository<_i23.PinEnrollmentState>>(),
            gh<_i12.StateRepository<_i10.PasswordEnrollmentState>>(),
            gh<_i12.StateRepository<_i20.PinChangeState>>(),
            gh<_i12.StateRepository<_i14.PasswordChangeState>>(),
          ));
  gh.factory<_i62.ChangePasswordUseCase>(() => _i62.ChangePasswordUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i15.PasswordChanger>(),
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
        gh<_i12.StateRepository<_i20.PinChangeState>>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.singleton<_i63.LocalDataBloc>(() => _i63.LocalDataBloc(
        gh<_i53.ClientProvider>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i64.DeregisterAllUseCase>(() => _i64.DeregisterAllUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i65.ChangeDeviceInformationUseCase>(
      () => _i65.ChangeDeviceInformationUseCaseImpl(
            gh<_i53.ClientProvider>(),
            gh<_i12.StateRepository<_i6.OperationType>>(),
            gh<_i28.DomainBloc>(),
            gh<_i41.ErrorHandler>(),
          ));
  gh.factory<_i66.OobPayloadDecodeUseCase>(
      () => _i66.OobPayloadDecodeUseCaseImpl(
            gh<_i53.ClientProvider>(),
            gh<_i12.StateRepository<_i6.OperationType>>(),
            gh<_i41.ErrorHandler>(),
          ));
  gh.factory<_i67.AuthenticatorsUseCase>(
      () => _i67.AuthenticatorsUseCaseImpl(gh<_i53.ClientProvider>()));
  gh.factory<_i68.AuthenticateUseCase>(() => _i68.AuthenticateUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i15.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i15.PinUserVerifier>(),
        gh<_i15.PasswordUserVerifier>(),
        gh<_i15.BiometricUserVerifier>(),
        gh<_i15.DevicePasscodeUserVerifier>(),
        gh<_i15.FingerprintUserVerifier>(),
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i69.DeviceInformationUseCase>(
      () => _i69.DeviceInformationUseCaseImpl(gh<_i53.ClientProvider>()));
  gh.singleton<_i70.AppBloc>(() => _i70.AppBloc(
        gh<_i55.DeregisterUseCase>(),
        gh<_i21.ConfigurationLoader>(),
        gh<_i41.ErrorHandler>(),
        gh<_i28.DomainBloc>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i71.ChangePinUseCase>(() => _i71.ChangePinUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i15.PinChanger>(),
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
        gh<_i12.StateRepository<_i20.PinChangeState>>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i72.CreateDeviceInformationUseCase>(() =>
      _i72.CreateDeviceInformationUseCaseImpl(
          gh<_i69.DeviceInformationUseCase>()));
  gh.factory<_i73.RegistrationUseCase>(() => _i73.RegistrationUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i72.CreateDeviceInformationUseCase>(),
        gh<_i15.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i15.PinEnroller>(),
        gh<_i15.PasswordEnroller>(),
        gh<_i15.BiometricUserVerifier>(),
        gh<_i15.DevicePasscodeUserVerifier>(),
        gh<_i15.FingerprintUserVerifier>(),
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i74.ResultBloc>(() => _i74.ResultBloc(
        gh<_i3.GlobalNavigationManager>(),
        gh<_i63.LocalDataBloc>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
      ));
  gh.factory<_i75.CredentialBloc>(() => _i75.CredentialBloc(
        gh<_i28.DomainBloc>(),
        gh<_i61.CancelCredentialOperationUseCase>(),
        gh<_i42.ProvidedCredentialsUseCase>(),
        gh<_i31.CancelUserInteractionOperationUseCase>(),
        gh<_i45.EnrollCredentialUseCase>(),
        gh<_i30.VerifyCredentialUseCase>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i76.OobProcessUseCase>(() => _i76.OobProcessUseCaseImpl(
        gh<_i53.ClientProvider>(),
        gh<_i72.CreateDeviceInformationUseCase>(),
        gh<_i66.OobPayloadDecodeUseCase>(),
        gh<_i15.AccountSelector>(),
        gh<_i15.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i15.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i15.PinEnroller>(),
        gh<_i15.PasswordEnroller>(),
        gh<_i15.PinUserVerifier>(),
        gh<_i15.PasswordUserVerifier>(),
        gh<_i15.BiometricUserVerifier>(),
        gh<_i15.DevicePasscodeUserVerifier>(),
        gh<_i15.FingerprintUserVerifier>(),
        gh<_i28.DomainBloc>(),
        gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
        gh<_i12.StateRepository<_i6.OperationType>>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i77.ChangeDeviceInformationBloc>(
      () => _i77.ChangeDeviceInformationBloc(
            gh<_i3.GlobalNavigationManager>(),
            gh<_i65.ChangeDeviceInformationUseCase>(),
            gh<_i69.DeviceInformationUseCase>(),
            gh<_i41.ErrorHandler>(),
          ));
  gh.factory<_i78.SelectAccountBloc>(() => _i78.SelectAccountBloc(
        gh<_i68.AuthenticateUseCase>(),
        gh<_i24.SelectAccountUseCase>(),
        gh<_i71.ChangePinUseCase>(),
        gh<_i62.ChangePasswordUseCase>(),
        gh<_i41.ErrorHandler>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i79.HomeBloc>(() => _i79.HomeBloc(
        gh<_i38.DeepLinkRepository>(),
        gh<_i21.ConfigurationLoader>(),
        gh<_i53.ClientProvider>(),
        gh<_i76.OobProcessUseCase>(),
        gh<_i56.RegisteredAccountsUseCase>(),
        gh<_i64.DeregisterAllUseCase>(),
        gh<_i67.AuthenticatorsUseCase>(),
        gh<_i71.ChangePinUseCase>(),
        gh<_i62.ChangePasswordUseCase>(),
        gh<_i60.DeleteAuthenticatorsUseCase>(),
        gh<_i63.LocalDataBloc>(),
        gh<_i41.ErrorHandler>(),
        gh<_i3.GlobalNavigationManager>(),
      ));
  gh.factory<_i80.ReadQrCodeBloc>(() => _i80.ReadQrCodeBloc(
        gh<_i76.OobProcessUseCase>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i81.LegacyLoginBloc>(() => _i81.LegacyLoginBloc(
        gh<_i21.ConfigurationLoader>(),
        gh<_i29.LoginUseCase>(),
        gh<_i73.RegistrationUseCase>(),
        gh<_i41.ErrorHandler>(),
      ));
  gh.factory<_i82.AuthCloudApiRegisterUseCase>(
      () => _i82.AuthCloudApiRegisterUseCaseImpl(
            gh<_i53.ClientProvider>(),
            gh<_i72.CreateDeviceInformationUseCase>(),
            gh<_i15.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
            gh<_i15.PinEnroller>(),
            gh<_i15.PasswordEnroller>(),
            gh<_i15.BiometricUserVerifier>(),
            gh<_i15.DevicePasscodeUserVerifier>(),
            gh<_i15.FingerprintUserVerifier>(),
            gh<_i28.DomainBloc>(),
            gh<_i12.StateRepository<_i9.UserInteractionOperationState>>(),
            gh<_i12.StateRepository<_i6.OperationType>>(),
            gh<_i41.ErrorHandler>(),
          ));
  gh.factory<_i83.AuthCloudApiRegistrationBloc>(
      () => _i83.AuthCloudApiRegistrationBloc(
            gh<_i3.GlobalNavigationManager>(),
            gh<_i82.AuthCloudApiRegisterUseCase>(),
            gh<_i41.ErrorHandler>(),
          ));
  return getIt;
}
