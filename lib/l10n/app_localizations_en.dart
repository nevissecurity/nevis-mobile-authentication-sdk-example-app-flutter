// Copyright © 2025 Nevis Security AG. All rights reserved.

// ignore_for_file: type=lint

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nevis Example App';

  @override
  String get authenticatorTitleBiometric => 'Face/Fingerprint';

  @override
  String get authenticatorTitleDevicePasscode => 'Device Passcode';

  @override
  String get authenticatorTitleFaceID => 'Face ID';

  @override
  String get authenticatorTitleFingerprint => 'Fingerprint';

  @override
  String get authenticatorTitleTouchID => 'Touch ID';

  @override
  String get authenticatorTitlePin => 'PIN';

  @override
  String get authenticatorTitlePassword => 'Password';

  @override
  String get authenticatorNotPolicyCompliant =>
      'This authentication method cannot be used with your application';

  @override
  String get authenticatorNotEnrolled =>
      'Before using the authenticator, enroll it in the phone System Settings';

  @override
  String get cancelButtonTitle => 'Cancel';

  @override
  String get confirmButtonTitle => 'Ok';

  @override
  String errorType(String errorType) {
    return 'Latest error: $errorType';
  }

  @override
  String error(String errorDescription) {
    return 'Latest error description: $errorDescription';
  }

  @override
  String get businessErrorTypeAccountsNotFound =>
      'No accounts were found for the operation.';

  @override
  String get businessErrorTypeAuthenticatorNotFound =>
      'No available authenticator found.';

  @override
  String get businessErrorTypeCameraAccessDenied =>
      'Camera access is denied. Please go to Settings and allow it.';

  @override
  String get businessErrorTypeDeviceInformationNotFound =>
      'No device information was found.';

  @override
  String get businessErrorTypeInvalidState => 'Invalid state.';

  @override
  String get businessErrorTypeMissingCookie =>
      'No cookie was provided in the legacy login response.';

  @override
  String get businessErrorTypeMissingDispatchTokenResponse =>
      'The returned URI did not have a dispatchTokenResponse query parameter.';

  @override
  String get businessErrorTypeCredentialAuthenticatorNotFound =>
      'Credential authenticator not found.';

  @override
  String get businessErrorTypeRegisteredAccountsNotFound =>
      'There are no registered accounts.';

  @override
  String get selectAccountScreenTitle => 'Select an account';

  @override
  String get selectAuthenticatorScreenTitle =>
      'Select an Authentication Method';

  @override
  String homeRegisteredAccounts(int accountNumber) {
    return 'Registered accounts: $accountNumber';
  }

  @override
  String get homeIdentitySuiteOnly => 'Identity Suite only';

  @override
  String get homeNevisMobileAuthenticationSdk =>
      'Nevis Mobile Authentication SDK';

  @override
  String get homeFacetId => 'Facet Id';

  @override
  String get homeCertificateFingerprint => 'Certificate Fingerprint';

  @override
  String get homeUnknownMetaData => 'Unknown';

  @override
  String get readQrCode => 'Read Qr Code';

  @override
  String get inBandAuthenticate => 'In-Band Authenticate';

  @override
  String get deregister => 'Deregister';

  @override
  String get pinChange => 'PIN Change';

  @override
  String get passwordChange => 'Password Change';

  @override
  String get changeDeviceInformation => 'Change Device Information';

  @override
  String get authCloudApiRegistration => 'Auth Cloud Api Registration';

  @override
  String get deleteAuthenticators => 'Delete Authenticators';

  @override
  String get inBandRegister => 'In-Band Register';

  @override
  String get readQrCodeScreenTitle => 'Read Qr Code';

  @override
  String get biometricPopUpTitle => 'Biometric authentication required';

  @override
  String get biometricPopUpDescription =>
      'Please use the default biometric method to identify yourself.';

  @override
  String get devicePasscodePopUpTitle => 'Passcode required';

  @override
  String get devicePasscodePopUpDescription =>
      'Please provide the device passcode.';

  @override
  String get credentialScreenTitlePinEnrollment => 'Create PIN';

  @override
  String get credentialScreenTitlePasswordEnrollment => 'Create Password';

  @override
  String get credentialScreenTitlePinVerification => 'Verify PIN';

  @override
  String get credentialScreenTitlePasswordVerification => 'Verify Password';

  @override
  String get credentialScreenTitlePinChange => 'Change PIN';

  @override
  String get credentialScreenTitlePasswordChange => 'Change Password';

  @override
  String get credentialScreenDescriptionPinEnrollment => 'Set your 6 digit PIN';

  @override
  String get credentialScreenDescriptionPasswordEnrollment =>
      'Set your Password';

  @override
  String get credentialScreenDescriptionPinVerification => 'Enter your PIN';

  @override
  String get credentialScreenDescriptionPasswordVerification =>
      'Enter your Password';

  @override
  String get credentialScreenDescriptionPinChange => 'Set your 6 digit PIN';

  @override
  String get credentialScreenDescriptionPasswordChange => 'Set your Password';

  @override
  String get credentialOldPinTitle => 'Old PIN';

  @override
  String get credentialOldPasswordTitle => 'Old Password';

  @override
  String get credentialOldPinPlaceholder => 'Enter old PIN';

  @override
  String get credentialOldPasswordPlaceholder => 'Enter old Password';

  @override
  String get credentialNewPinTitle => 'New PIN';

  @override
  String get credentialNewPasswordTitle => 'New Password';

  @override
  String get credentialNewPinPlaceholder => 'Enter new PIN';

  @override
  String get credentialNewPasswordPlaceholder => 'Enter new Password';

  @override
  String get credentialPinTitle => 'PIN';

  @override
  String get credentialPasswordTitle => 'Password';

  @override
  String get credentialPinPlaceholder => 'Enter PIN';

  @override
  String get credentialPasswordPlaceholder => 'Enter Password';

  @override
  String authenticatorProtectionStatusLastAttemptFailed(
      int retryCount, int coolDown) {
    return 'Invalid credential was provided previously. Authenticator is unlocked. You have $retryCount try left.\nPlease retry in $coolDown seconds.';
  }

  @override
  String get authenticatorProtectionStatusLocked => 'Authenticator is locked.';

  @override
  String get transactionConfirmationScreenTitle => 'Transaction confirmation';

  @override
  String confirmationScreenDescription(String authenticator) {
    return 'Authenticate using $authenticator';
  }

  @override
  String get confirmationScreenDescriptionFingerprintVerification =>
      'Use Fingerprint sensor to authenticate.';

  @override
  String operationFailedResultTitle(String operation) {
    return '$operation failed!';
  }

  @override
  String operationSucceededResultTitle(String operation) {
    return '$operation succeeded!';
  }

  @override
  String get operationTypeInit => 'Init SDK';

  @override
  String get operationTypeRegistration => 'Registration';

  @override
  String get operationTypeAuthCloudApiRegistration => 'Auth Cloud Registration';

  @override
  String get operationTypeAuthentication => 'Authentication';

  @override
  String get operationTypeDeregistration => 'Deregistration';

  @override
  String get operationTypePinChange => 'PIN change';

  @override
  String get operationTypePasswordChange => 'Password change';

  @override
  String get operationTypeDeviceInformationChange =>
      'Device information change';

  @override
  String get operationTypePayloadDecode => 'Payload decode';

  @override
  String get operationTypeLocalData => 'Local Data operation';

  @override
  String get operationTypeUnknown => 'Operation';

  @override
  String get registrationScreenTitle => 'In-Band Registration';

  @override
  String get registrationUsernameTitle => 'Username';

  @override
  String get registrationUsernamePlaceholder => 'Enter username';

  @override
  String get registrationPasswordTitle => 'Password';

  @override
  String get registrationPasswordPlaceholder => 'Enter password';

  @override
  String get changeDeviceInformationTitle => 'Change Device Information';

  @override
  String changeDeviceInformationCurrentName(String currentName) {
    return 'Current name: $currentName';
  }

  @override
  String get changeDeviceInformationNewName => 'New name';

  @override
  String get changeDeviceInformationEmptyCurrentName =>
      'There is no name given to the device information currently!';

  @override
  String get authCloudApiRegistrationTitle => 'Auth Cloud Registration';

  @override
  String get authCloudApiRegistrationEnrollResponse => 'Enroll response';

  @override
  String get authCloudApiRegistrationAppLinkUri => 'App Link Uri';

  @override
  String get authCloudApiRegistrationErrorMissingData =>
      'Either the response or the appLinkUri is required.';

  @override
  String get authCloudApiRegistrationErrorWrongData =>
      'You cannot provide both the response and the appLinkUri.';
}
