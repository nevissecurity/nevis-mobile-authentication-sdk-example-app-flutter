// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart'
    as _i150;

import 'configuration/configuration_loader.dart' as _i425;
import 'data/cache/cache.dart' as _i452;
import 'data/cache/state_cache.dart' as _i787;
import 'data/datasource/deep_link/deep_link_datasource.dart' as _i461;
import 'data/datasource/login/login_datasource.dart' as _i524;
import 'data/repository/deep_link_repository_impl.dart' as _i675;
import 'data/repository/login_repository_impl.dart' as _i371;
import 'data/repository/state_repository_impl.dart' as _i281;
import 'domain/batch_call/batch_call.dart' as _i1028;
import 'domain/blocs/domain_state/domain_bloc.dart' as _i218;
import 'domain/blocs/local_data/local_data_bloc.dart' as _i165;
import 'domain/client_provider/client_provider.dart' as _i965;
import 'domain/error/error_handler.dart' as _i711;
import 'domain/interaction/account_selector_impl.dart' as _i902;
import 'domain/interaction/authentication_authenticator_selector_impl.dart'
    as _i316;
import 'domain/interaction/biometric_user_verifier_impl.dart' as _i274;
import 'domain/interaction/device_passcode_user_verifier_impl.dart' as _i737;
import 'domain/interaction/fingerprint_user_verifier_impl.dart' as _i716;
import 'domain/interaction/password_changer.dart' as _i147;
import 'domain/interaction/password_enroller.dart' as _i1054;
import 'domain/interaction/password_user_verifier.dart' as _i536;
import 'domain/interaction/pin_changer_impl.dart' as _i790;
import 'domain/interaction/pin_enroller_impl.dart' as _i445;
import 'domain/interaction/pin_user_verifier_impl.dart' as _i809;
import 'domain/interaction/registration_authenticator_selector_impl.dart'
    as _i78;
import 'domain/model/operation/operation_type.dart' as _i761;
import 'domain/model/operation/password_change_state.dart' as _i17;
import 'domain/model/operation/password_enrollment_state.dart' as _i966;
import 'domain/model/operation/pin_change_state.dart' as _i1064;
import 'domain/model/operation/pin_enrollment_state.dart' as _i291;
import 'domain/model/operation/user_interaction_operation_state.dart' as _i954;
import 'domain/repository/deep_link_repository.dart' as _i640;
import 'domain/repository/login_repository.dart' as _i373;
import 'domain/repository/state_repository.dart' as _i404;
import 'domain/usecase/auth_cloud_api_register_usecase.dart' as _i346;
import 'domain/usecase/authenticate_usecase.dart' as _i476;
import 'domain/usecase/authenticators_usecase.dart' as _i453;
import 'domain/usecase/biometric_listen_for_os_credentials_usecase.dart'
    as _i316;
import 'domain/usecase/cancel_credential_operation_usecase.dart' as _i1003;
import 'domain/usecase/cancel_user_interaction_operation_usecase.dart' as _i125;
import 'domain/usecase/change_device_information_usecase.dart' as _i956;
import 'domain/usecase/change_password_usecase.dart' as _i90;
import 'domain/usecase/change_pin_usecase.dart' as _i311;
import 'domain/usecase/create_device_information_usecase.dart' as _i587;
import 'domain/usecase/delete_authenticators_usecase.dart' as _i776;
import 'domain/usecase/deregister_all_usecase.dart' as _i286;
import 'domain/usecase/deregister_usecase.dart' as _i306;
import 'domain/usecase/device_information_usecase.dart' as _i906;
import 'domain/usecase/device_passcode_listen_for_os_credentials_usecase.dart'
    as _i609;
import 'domain/usecase/enroll_credential_usecase.dart' as _i457;
import 'domain/usecase/fingerprint_listen_for_os_credentials_usecase.dart'
    as _i619;
import 'domain/usecase/login_usecase.dart' as _i579;
import 'domain/usecase/oob_payload_decode_usecase.dart' as _i535;
import 'domain/usecase/oob_process_usecase.dart' as _i1054;
import 'domain/usecase/pause_listening_usecase.dart' as _i965;
import 'domain/usecase/provided_credentials_usecase.dart' as _i521;
import 'domain/usecase/registered_accounts_usecase.dart' as _i382;
import 'domain/usecase/registration_usecase.dart' as _i353;
import 'domain/usecase/reset_user_interaction_state_usecase.dart' as _i415;
import 'domain/usecase/resume_listening_usecase.dart' as _i836;
import 'domain/usecase/select_account_usecase.dart' as _i501;
import 'domain/usecase/select_authenticator_usecase.dart' as _i472;
import 'domain/usecase/verify_credential_usecase.dart' as _i942;
import 'domain/validation/account_validator.dart' as _i657;
import 'domain/validation/authenticator_validator.dart' as _i517;
import 'domain/validation/password_policy_impl.dart' as _i1030;
import 'navigation/app_navigation.dart' as _i1056;
import 'navigation/global_navigation_manager.dart' as _i341;
import 'ui/app_state/app_bloc.dart' as _i196;
import 'ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart'
    as _i220;
import 'ui/screens/change_device_information/change_device_information_bloc.dart'
    as _i153;
import 'ui/screens/confirmation/confirmation_bloc.dart' as _i988;
import 'ui/screens/credential/credential_bloc.dart' as _i478;
import 'ui/screens/home/home_bloc.dart' as _i286;
import 'ui/screens/legacy_login/legacy_login_bloc.dart' as _i429;
import 'ui/screens/read_qr_code/read_qr_code_bloc.dart' as _i185;
import 'ui/screens/result/result_bloc.dart' as _i300;
import 'ui/screens/select_account/select_account_bloc.dart' as _i704;
import 'ui/screens/select_authenticator/select_authenticator_bloc.dart'
    as _i244;
import 'ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart'
    as _i592;

const String _authenticationCloud = 'authenticationCloud';
const String _identitySuite = 'identitySuite';

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i341.GlobalNavigationManager>(
      () => _i341.GlobalNavigationManager());
  gh.singleton<_i1056.AppNavigation>(() => _i1056.AppNavigation());
  gh.singleton<_i452.Cache<_i761.OperationType>>(
      () => _i787.OperationTypeCacheImpl());
  gh.factory<_i524.LoginDataSource>(() => _i524.LoginDataSourceImpl());
  gh.singleton<_i452.Cache<_i954.UserInteractionOperationState>>(
      () => _i787.UserInteractionOperationStateCacheImpl());
  gh.singleton<_i452.Cache<_i966.PasswordEnrollmentState>>(
      () => _i787.PasswordEnrollmentStateCacheImpl());
  gh.singleton<_i461.DeepLinkDataSource>(() => _i461.DeepLinkDataSourceImpl());
  gh.factory<_i404.StateRepository<_i966.PasswordEnrollmentState>>(() =>
      _i281.PasswordEnrollmentStateRepositoryImpl(
          gh<_i452.Cache<_i966.PasswordEnrollmentState>>()));
  gh.singleton<_i452.Cache<_i17.PasswordChangeState>>(
      () => _i787.PasswordChangeStateCacheImpl());
  gh.factory<_i150.PasswordPolicy>(() => _i1030.PasswordPolicyImpl());
  gh.factory<_i373.LoginRepository>(
      () => _i371.LoginRepositoryImpl(gh<_i524.LoginDataSource>()));
  gh.factory<_i517.AuthenticatorValidator>(
      () => _i517.AuthenticatorValidatorImpl());
  gh.singleton<_i452.Cache<_i1064.PinChangeState>>(
      () => _i787.PinChangeStateCacheImpl());
  gh.singleton<_i425.ConfigurationLoader>(
    () => _i425.AuthenticationCloudConfigurationLoader(),
    registerFor: {_authenticationCloud},
  );
  gh.singleton<_i425.ConfigurationLoader>(
    () => _i425.IdentitySuiteConfigurationLoader(),
    registerFor: {_identitySuite},
  );
  gh.factory<_i404.StateRepository<_i1064.PinChangeState>>(() =>
      _i281.PinChangeStateRepositoryImpl(
          gh<_i452.Cache<_i1064.PinChangeState>>()));
  gh.factory<_i657.AccountValidator>(() => _i657.AccountValidatorImpl());
  gh.singleton<_i452.Cache<_i291.PinEnrollmentState>>(
      () => _i787.PinEnrollmentStateCacheImpl());
  gh.factory<_i404.StateRepository<_i17.PasswordChangeState>>(() =>
      _i281.PasswordChangeStateRepositoryImpl(
          gh<_i452.Cache<_i17.PasswordChangeState>>()));
  gh.factory<_i404.StateRepository<_i954.UserInteractionOperationState>>(() =>
      _i281.UserInteractionOperationStateRepositoryImpl(
          gh<_i452.Cache<_i954.UserInteractionOperationState>>()));
  gh.factory<_i501.SelectAccountUseCase>(() => _i501.SelectAccountUseCaseImpl(
      gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i965.PauseListeningUseCase>(() => _i965.PauseListeningUseCaseImpl(
      gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i609.DevicePasscodeListenForOsCredentialsUseCase>(() =>
      _i609.DevicePasscodeListenForOsCredentialsUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i316.BiometricListenForOsCredentialsUseCase>(() =>
      _i316.BiometricListenForOsCredentialsUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i404.StateRepository<_i761.OperationType>>(() =>
      _i281.OperationTypeRepositoryImpl(
          gh<_i452.Cache<_i761.OperationType>>()));
  gh.singleton<_i218.DomainBloc>(() => _i218.DomainBloc(
      gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i579.LoginUseCase>(
      () => _i579.LoginUseCaseImpl(gh<_i373.LoginRepository>()));
  gh.factory<_i942.VerifyCredentialUseCase>(() =>
      _i942.VerifyCredentialUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i125.CancelUserInteractionOperationUseCase>(() =>
      _i125.CancelUserInteractionOperationUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i150.PasswordChanger>(() => _i147.PasswordChangerImpl(
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i17.PasswordChangeState>>(),
        gh<_i150.PasswordPolicy>(),
      ));
  gh.factory<_i150.PinChanger>(() => _i790.PinChangerImpl(
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i1064.PinChangeState>>(),
      ));
  gh.factory<_i415.ResetUserInteractionStateUseCase>(() =>
      _i415.ResetUserInteractionStateUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i619.FingerPrintListenForOsCredentialsUseCase>(() =>
      _i619.FingerPrintListenForOsCredentialsUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i836.ResumeListeningUseCase>(() =>
      _i836.ResumeListeningUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i472.SelectAuthenticatorUseCase>(() =>
      _i472.SelectAuthenticatorUseCaseImpl(
          gh<_i404.StateRepository<_i954.UserInteractionOperationState>>()));
  gh.factory<_i640.DeepLinkRepository>(
      () => _i675.DeepLinkRepositoryImpl(gh<_i461.DeepLinkDataSource>()));
  gh.factory<_i150.PasswordEnroller>(() => _i1054.PasswordEnrollerImpl(
        gh<_i404.StateRepository<_i966.PasswordEnrollmentState>>(),
        gh<_i218.DomainBloc>(),
        gh<_i150.PasswordPolicy>(),
      ));
  gh.factory<_i404.StateRepository<_i291.PinEnrollmentState>>(() =>
      _i281.PinEnrollmentStateRepositoryImpl(
          gh<_i452.Cache<_i291.PinEnrollmentState>>()));
  gh.factory<_i711.ErrorHandler>(() => _i711.ErrorHandlerImpl(
        gh<_i341.GlobalNavigationManager>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
      ));
  gh.factory<_i521.ProvidedCredentialsUseCase>(
      () => _i521.ProvidedCredentialsUseCaseImpl(
            gh<_i404.StateRepository<_i1064.PinChangeState>>(),
            gh<_i404.StateRepository<_i17.PasswordChangeState>>(),
          ));
  gh.factory<_i150.PinEnroller>(() => _i445.PinEnrollerImpl(
        gh<_i404.StateRepository<_i291.PinEnrollmentState>>(),
        gh<_i218.DomainBloc>(),
      ));
  gh.factory<_i150.AuthenticatorSelector>(
    () => _i78.RegistrationAuthenticatorSelectorImpl(
      gh<_i218.DomainBloc>(),
      gh<_i425.ConfigurationLoader>(),
      gh<_i517.AuthenticatorValidator>(),
      gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_reg',
  );
  gh.factory<_i457.EnrollCredentialUseCase>(
      () => _i457.EnrollCredentialUseCaseImpl(
            gh<_i404.StateRepository<_i291.PinEnrollmentState>>(),
            gh<_i404.StateRepository<_i966.PasswordEnrollmentState>>(),
          ));
  gh.factory<_i150.AuthenticatorSelector>(
    () => _i316.AuthenticationAuthenticatorSelectorImpl(
      gh<_i218.DomainBloc>(),
      gh<_i425.ConfigurationLoader>(),
      gh<_i517.AuthenticatorValidator>(),
      gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
    ),
    instanceName: 'auth_selector_auth',
  );
  gh.factory<_i592.TransactionConfirmationBloc>(
      () => _i592.TransactionConfirmationBloc(
            gh<_i711.ErrorHandler>(),
            gh<_i501.SelectAccountUseCase>(),
            gh<_i125.CancelUserInteractionOperationUseCase>(),
            gh<_i341.GlobalNavigationManager>(),
          ));
  gh.factory<_i150.AccountSelector>(() => _i902.AccountSelectorImpl(
        gh<_i218.DomainBloc>(),
        gh<_i711.ErrorHandler>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
        gh<_i657.AccountValidator>(),
      ));
  gh.factory<_i988.ConfirmationBloc>(() => _i988.ConfirmationBloc(
        gh<_i316.BiometricListenForOsCredentialsUseCase>(),
        gh<_i619.FingerPrintListenForOsCredentialsUseCase>(),
        gh<_i609.DevicePasscodeListenForOsCredentialsUseCase>(),
        gh<_i125.CancelUserInteractionOperationUseCase>(),
        gh<_i965.PauseListeningUseCase>(),
        gh<_i836.ResumeListeningUseCase>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i1028.BatchCall>(() => _i1028.BatchCallImpl(
        gh<_i218.DomainBloc>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i150.BiometricUserVerifier>(() => _i274.BiometricUserVerifierImpl(
        gh<_i218.DomainBloc>(),
        gh<_i711.ErrorHandler>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
      ));
  gh.factory<_i150.DevicePasscodeUserVerifier>(
      () => _i737.DevicePasscodeUserVerifierImpl(
            gh<_i218.DomainBloc>(),
            gh<_i711.ErrorHandler>(),
            gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
          ));
  gh.factory<_i965.ClientProvider>(() => _i965.ClientProviderImpl(
        gh<_i404.StateRepository<_i761.OperationType>>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i150.PinUserVerifier>(() => _i809.PinUserVerifierImpl(
        gh<_i218.DomainBloc>(),
        gh<_i711.ErrorHandler>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
      ));
  gh.factory<_i306.DeregisterUseCase>(() => _i306.DeregisterUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
      ));
  gh.factory<_i382.RegisteredAccountsUseCase>(
      () => _i382.RegisteredAccountsUseCaseImpl(gh<_i965.ClientProvider>()));
  gh.factory<_i150.PasswordUserVerifier>(() => _i536.PasswordUserVerifierImpl(
        gh<_i218.DomainBloc>(),
        gh<_i711.ErrorHandler>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
      ));
  gh.factory<_i244.SelectAuthenticatorBloc>(() => _i244.SelectAuthenticatorBloc(
        gh<_i472.SelectAuthenticatorUseCase>(),
        gh<_i341.GlobalNavigationManager>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i150.FingerprintUserVerifier>(
      () => _i716.FingerprintUserVerifierImpl(
            gh<_i218.DomainBloc>(),
            gh<_i711.ErrorHandler>(),
            gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
          ));
  gh.factory<_i776.DeleteAuthenticatorsUseCase>(
      () => _i776.DeleteAuthenticatorsUseCaseImpl(
            gh<_i965.ClientProvider>(),
            gh<_i404.StateRepository<_i761.OperationType>>(),
          ));
  gh.factory<_i1003.CancelCredentialOperationUseCase>(
      () => _i1003.CancelCredentialOperationUseCaseImpl(
            gh<_i404.StateRepository<_i291.PinEnrollmentState>>(),
            gh<_i404.StateRepository<_i966.PasswordEnrollmentState>>(),
            gh<_i404.StateRepository<_i1064.PinChangeState>>(),
            gh<_i404.StateRepository<_i17.PasswordChangeState>>(),
          ));
  gh.factory<_i90.ChangePasswordUseCase>(() => _i90.ChangePasswordUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i150.PasswordChanger>(),
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
        gh<_i404.StateRepository<_i1064.PinChangeState>>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.singleton<_i165.LocalDataBloc>(() => _i165.LocalDataBloc(
        gh<_i965.ClientProvider>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i286.DeregisterAllUseCase>(() => _i286.DeregisterAllUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
      ));
  gh.factory<_i956.ChangeDeviceInformationUseCase>(
      () => _i956.ChangeDeviceInformationUseCaseImpl(
            gh<_i965.ClientProvider>(),
            gh<_i404.StateRepository<_i761.OperationType>>(),
            gh<_i218.DomainBloc>(),
            gh<_i711.ErrorHandler>(),
          ));
  gh.factory<_i535.OobPayloadDecodeUseCase>(
      () => _i535.OobPayloadDecodeUseCaseImpl(
            gh<_i965.ClientProvider>(),
            gh<_i404.StateRepository<_i761.OperationType>>(),
            gh<_i711.ErrorHandler>(),
          ));
  gh.factory<_i453.AuthenticatorsUseCase>(
      () => _i453.AuthenticatorsUseCaseImpl(gh<_i965.ClientProvider>()));
  gh.factory<_i476.AuthenticateUseCase>(() => _i476.AuthenticateUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i150.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i150.PinUserVerifier>(),
        gh<_i150.PasswordUserVerifier>(),
        gh<_i150.BiometricUserVerifier>(),
        gh<_i150.DevicePasscodeUserVerifier>(),
        gh<_i150.FingerprintUserVerifier>(),
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i906.DeviceInformationUseCase>(
      () => _i906.DeviceInformationUseCaseImpl(gh<_i965.ClientProvider>()));
  gh.singleton<_i196.AppBloc>(() => _i196.AppBloc(
        gh<_i306.DeregisterUseCase>(),
        gh<_i425.ConfigurationLoader>(),
        gh<_i711.ErrorHandler>(),
        gh<_i218.DomainBloc>(),
        gh<_i341.GlobalNavigationManager>(),
      ));
  gh.factory<_i311.ChangePinUseCase>(() => _i311.ChangePinUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i150.PinChanger>(),
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
        gh<_i404.StateRepository<_i1064.PinChangeState>>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i587.CreateDeviceInformationUseCase>(() =>
      _i587.CreateDeviceInformationUseCaseImpl(
          gh<_i906.DeviceInformationUseCase>()));
  gh.factory<_i353.RegistrationUseCase>(() => _i353.RegistrationUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i587.CreateDeviceInformationUseCase>(),
        gh<_i150.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i150.PinEnroller>(),
        gh<_i150.PasswordEnroller>(),
        gh<_i150.BiometricUserVerifier>(),
        gh<_i150.DevicePasscodeUserVerifier>(),
        gh<_i150.FingerprintUserVerifier>(),
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i300.ResultBloc>(() => _i300.ResultBloc(
        gh<_i341.GlobalNavigationManager>(),
        gh<_i165.LocalDataBloc>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
      ));
  gh.factory<_i478.CredentialBloc>(() => _i478.CredentialBloc(
        gh<_i218.DomainBloc>(),
        gh<_i1003.CancelCredentialOperationUseCase>(),
        gh<_i521.ProvidedCredentialsUseCase>(),
        gh<_i125.CancelUserInteractionOperationUseCase>(),
        gh<_i457.EnrollCredentialUseCase>(),
        gh<_i942.VerifyCredentialUseCase>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i1054.OobProcessUseCase>(() => _i1054.OobProcessUseCaseImpl(
        gh<_i965.ClientProvider>(),
        gh<_i587.CreateDeviceInformationUseCase>(),
        gh<_i535.OobPayloadDecodeUseCase>(),
        gh<_i150.AccountSelector>(),
        gh<_i150.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
        gh<_i150.AuthenticatorSelector>(instanceName: 'auth_selector_auth'),
        gh<_i150.PinEnroller>(),
        gh<_i150.PasswordEnroller>(),
        gh<_i150.PinUserVerifier>(),
        gh<_i150.PasswordUserVerifier>(),
        gh<_i150.BiometricUserVerifier>(),
        gh<_i150.DevicePasscodeUserVerifier>(),
        gh<_i150.FingerprintUserVerifier>(),
        gh<_i218.DomainBloc>(),
        gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
        gh<_i404.StateRepository<_i761.OperationType>>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i153.ChangeDeviceInformationBloc>(
      () => _i153.ChangeDeviceInformationBloc(
            gh<_i341.GlobalNavigationManager>(),
            gh<_i956.ChangeDeviceInformationUseCase>(),
            gh<_i906.DeviceInformationUseCase>(),
            gh<_i711.ErrorHandler>(),
          ));
  gh.factory<_i704.SelectAccountBloc>(() => _i704.SelectAccountBloc(
        gh<_i476.AuthenticateUseCase>(),
        gh<_i501.SelectAccountUseCase>(),
        gh<_i311.ChangePinUseCase>(),
        gh<_i90.ChangePasswordUseCase>(),
        gh<_i711.ErrorHandler>(),
        gh<_i341.GlobalNavigationManager>(),
      ));
  gh.factory<_i286.HomeBloc>(() => _i286.HomeBloc(
        gh<_i640.DeepLinkRepository>(),
        gh<_i425.ConfigurationLoader>(),
        gh<_i965.ClientProvider>(),
        gh<_i1054.OobProcessUseCase>(),
        gh<_i382.RegisteredAccountsUseCase>(),
        gh<_i286.DeregisterAllUseCase>(),
        gh<_i453.AuthenticatorsUseCase>(),
        gh<_i311.ChangePinUseCase>(),
        gh<_i90.ChangePasswordUseCase>(),
        gh<_i776.DeleteAuthenticatorsUseCase>(),
        gh<_i165.LocalDataBloc>(),
        gh<_i711.ErrorHandler>(),
        gh<_i341.GlobalNavigationManager>(),
      ));
  gh.factory<_i185.ReadQrCodeBloc>(() => _i185.ReadQrCodeBloc(
        gh<_i1054.OobProcessUseCase>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i429.LegacyLoginBloc>(() => _i429.LegacyLoginBloc(
        gh<_i425.ConfigurationLoader>(),
        gh<_i579.LoginUseCase>(),
        gh<_i353.RegistrationUseCase>(),
        gh<_i711.ErrorHandler>(),
      ));
  gh.factory<_i346.AuthCloudApiRegisterUseCase>(
      () => _i346.AuthCloudApiRegisterUseCaseImpl(
            gh<_i965.ClientProvider>(),
            gh<_i587.CreateDeviceInformationUseCase>(),
            gh<_i150.AuthenticatorSelector>(instanceName: 'auth_selector_reg'),
            gh<_i150.PinEnroller>(),
            gh<_i150.PasswordEnroller>(),
            gh<_i150.BiometricUserVerifier>(),
            gh<_i150.DevicePasscodeUserVerifier>(),
            gh<_i150.FingerprintUserVerifier>(),
            gh<_i218.DomainBloc>(),
            gh<_i404.StateRepository<_i954.UserInteractionOperationState>>(),
            gh<_i404.StateRepository<_i761.OperationType>>(),
            gh<_i711.ErrorHandler>(),
          ));
  gh.factory<_i220.AuthCloudApiRegistrationBloc>(
      () => _i220.AuthCloudApiRegistrationBloc(
            gh<_i341.GlobalNavigationManager>(),
            gh<_i346.AuthCloudApiRegisterUseCase>(),
            gh<_i711.ErrorHandler>(),
          ));
  return getIt;
}
