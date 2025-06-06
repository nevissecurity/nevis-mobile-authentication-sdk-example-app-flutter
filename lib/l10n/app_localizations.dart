// Copyright © 2025 Nevis Security AG. All rights reserved.

// ignore_for_file: type=lint

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Nevis Example App'**
  String get appTitle;

  /// No description provided for @authenticatorTitleBiometric.
  ///
  /// In en, this message translates to:
  /// **'Face/Fingerprint'**
  String get authenticatorTitleBiometric;

  /// No description provided for @authenticatorTitleDevicePasscode.
  ///
  /// In en, this message translates to:
  /// **'Device Passcode'**
  String get authenticatorTitleDevicePasscode;

  /// No description provided for @authenticatorTitleFaceID.
  ///
  /// In en, this message translates to:
  /// **'Face ID'**
  String get authenticatorTitleFaceID;

  /// No description provided for @authenticatorTitleFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint'**
  String get authenticatorTitleFingerprint;

  /// No description provided for @authenticatorTitleTouchID.
  ///
  /// In en, this message translates to:
  /// **'Touch ID'**
  String get authenticatorTitleTouchID;

  /// No description provided for @authenticatorTitlePin.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get authenticatorTitlePin;

  /// No description provided for @authenticatorTitlePassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authenticatorTitlePassword;

  /// No description provided for @authenticatorNotPolicyCompliant.
  ///
  /// In en, this message translates to:
  /// **'This authentication method cannot be used with your application'**
  String get authenticatorNotPolicyCompliant;

  /// No description provided for @authenticatorNotEnrolled.
  ///
  /// In en, this message translates to:
  /// **'Before using the authenticator, enroll it in the phone System Settings'**
  String get authenticatorNotEnrolled;

  /// No description provided for @cancelButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonTitle;

  /// No description provided for @confirmButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get confirmButtonTitle;

  /// No description provided for @errorType.
  ///
  /// In en, this message translates to:
  /// **'Latest error: {errorType}'**
  String errorType(String errorType);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Latest error description: {errorDescription}'**
  String error(String errorDescription);

  /// No description provided for @businessErrorTypeAccountsNotFound.
  ///
  /// In en, this message translates to:
  /// **'No accounts were found for the operation.'**
  String get businessErrorTypeAccountsNotFound;

  /// No description provided for @businessErrorTypeAuthenticatorNotFound.
  ///
  /// In en, this message translates to:
  /// **'No available authenticator found.'**
  String get businessErrorTypeAuthenticatorNotFound;

  /// No description provided for @businessErrorTypeCameraAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera access is denied. Please go to Settings and allow it.'**
  String get businessErrorTypeCameraAccessDenied;

  /// No description provided for @businessErrorTypeDeviceInformationNotFound.
  ///
  /// In en, this message translates to:
  /// **'No device information was found.'**
  String get businessErrorTypeDeviceInformationNotFound;

  /// No description provided for @businessErrorTypeInvalidState.
  ///
  /// In en, this message translates to:
  /// **'Invalid state.'**
  String get businessErrorTypeInvalidState;

  /// No description provided for @businessErrorTypeMissingCookie.
  ///
  /// In en, this message translates to:
  /// **'No cookie was provided in the legacy login response.'**
  String get businessErrorTypeMissingCookie;

  /// No description provided for @businessErrorTypeMissingDispatchTokenResponse.
  ///
  /// In en, this message translates to:
  /// **'The returned URI did not have a dispatchTokenResponse query parameter.'**
  String get businessErrorTypeMissingDispatchTokenResponse;

  /// No description provided for @businessErrorTypeCredentialAuthenticatorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Credential authenticator not found.'**
  String get businessErrorTypeCredentialAuthenticatorNotFound;

  /// No description provided for @businessErrorTypeRegisteredAccountsNotFound.
  ///
  /// In en, this message translates to:
  /// **'There are no registered accounts.'**
  String get businessErrorTypeRegisteredAccountsNotFound;

  /// No description provided for @selectAccountScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Select an account'**
  String get selectAccountScreenTitle;

  /// No description provided for @selectAuthenticatorScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Select an Authentication Method'**
  String get selectAuthenticatorScreenTitle;

  /// No description provided for @homeRegisteredAccounts.
  ///
  /// In en, this message translates to:
  /// **'Registered accounts: {accountNumber}'**
  String homeRegisteredAccounts(int accountNumber);

  /// No description provided for @homeIdentitySuiteOnly.
  ///
  /// In en, this message translates to:
  /// **'Identity Suite only'**
  String get homeIdentitySuiteOnly;

  /// No description provided for @homeNevisMobileAuthenticationSdk.
  ///
  /// In en, this message translates to:
  /// **'Nevis Mobile Authentication SDK'**
  String get homeNevisMobileAuthenticationSdk;

  /// No description provided for @homeFacetId.
  ///
  /// In en, this message translates to:
  /// **'Facet Id'**
  String get homeFacetId;

  /// No description provided for @homeCertificateFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Certificate Fingerprint'**
  String get homeCertificateFingerprint;

  /// No description provided for @homeUnknownMetaData.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get homeUnknownMetaData;

  /// No description provided for @homeSupportedAttestation.
  ///
  /// In en, this message translates to:
  /// **'FIDO UAF Attestation Supported by Device'**
  String get homeSupportedAttestation;

  /// No description provided for @homeSurrogateBasic.
  ///
  /// In en, this message translates to:
  /// **'Surrogate basic'**
  String get homeSurrogateBasic;

  /// No description provided for @homeFullBasicDefault.
  ///
  /// In en, this message translates to:
  /// **'Full basic default mode'**
  String get homeFullBasicDefault;

  /// No description provided for @homeFullBasicStrict.
  ///
  /// In en, this message translates to:
  /// **'Full basic strict mode'**
  String get homeFullBasicStrict;

  /// No description provided for @readQrCode.
  ///
  /// In en, this message translates to:
  /// **'Read Qr Code'**
  String get readQrCode;

  /// No description provided for @inBandAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'In-Band Authenticate'**
  String get inBandAuthenticate;

  /// No description provided for @deregister.
  ///
  /// In en, this message translates to:
  /// **'Deregister'**
  String get deregister;

  /// No description provided for @pinChange.
  ///
  /// In en, this message translates to:
  /// **'PIN Change'**
  String get pinChange;

  /// No description provided for @passwordChange.
  ///
  /// In en, this message translates to:
  /// **'Password Change'**
  String get passwordChange;

  /// No description provided for @changeDeviceInformation.
  ///
  /// In en, this message translates to:
  /// **'Change Device Information'**
  String get changeDeviceInformation;

  /// No description provided for @authCloudApiRegistration.
  ///
  /// In en, this message translates to:
  /// **'Auth Cloud Api Registration'**
  String get authCloudApiRegistration;

  /// No description provided for @deleteAuthenticators.
  ///
  /// In en, this message translates to:
  /// **'Delete Authenticators'**
  String get deleteAuthenticators;

  /// No description provided for @inBandRegister.
  ///
  /// In en, this message translates to:
  /// **'In-Band Register'**
  String get inBandRegister;

  /// No description provided for @readQrCodeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Read Qr Code'**
  String get readQrCodeScreenTitle;

  /// No description provided for @biometricPopUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication required'**
  String get biometricPopUpTitle;

  /// No description provided for @biometricPopUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Please use the default biometric method to identify yourself.'**
  String get biometricPopUpDescription;

  /// No description provided for @devicePasscodePopUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Passcode required'**
  String get devicePasscodePopUpTitle;

  /// No description provided for @devicePasscodePopUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Please provide the device passcode.'**
  String get devicePasscodePopUpDescription;

  /// No description provided for @credentialScreenTitlePinEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Create PIN'**
  String get credentialScreenTitlePinEnrollment;

  /// No description provided for @credentialScreenTitlePasswordEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get credentialScreenTitlePasswordEnrollment;

  /// No description provided for @credentialScreenTitlePinVerification.
  ///
  /// In en, this message translates to:
  /// **'Verify PIN'**
  String get credentialScreenTitlePinVerification;

  /// No description provided for @credentialScreenTitlePasswordVerification.
  ///
  /// In en, this message translates to:
  /// **'Verify Password'**
  String get credentialScreenTitlePasswordVerification;

  /// No description provided for @credentialScreenTitlePinChange.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get credentialScreenTitlePinChange;

  /// No description provided for @credentialScreenTitlePasswordChange.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get credentialScreenTitlePasswordChange;

  /// No description provided for @credentialScreenDescriptionPinEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Set your 6 digit PIN'**
  String get credentialScreenDescriptionPinEnrollment;

  /// No description provided for @credentialScreenDescriptionPasswordEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Set your Password'**
  String get credentialScreenDescriptionPasswordEnrollment;

  /// No description provided for @credentialScreenDescriptionPinVerification.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get credentialScreenDescriptionPinVerification;

  /// No description provided for @credentialScreenDescriptionPasswordVerification.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get credentialScreenDescriptionPasswordVerification;

  /// No description provided for @credentialScreenDescriptionPinChange.
  ///
  /// In en, this message translates to:
  /// **'Set your 6 digit PIN'**
  String get credentialScreenDescriptionPinChange;

  /// No description provided for @credentialScreenDescriptionPasswordChange.
  ///
  /// In en, this message translates to:
  /// **'Set your Password'**
  String get credentialScreenDescriptionPasswordChange;

  /// No description provided for @credentialOldPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Old PIN'**
  String get credentialOldPinTitle;

  /// No description provided for @credentialOldPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get credentialOldPasswordTitle;

  /// No description provided for @credentialOldPinPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter old PIN'**
  String get credentialOldPinPlaceholder;

  /// No description provided for @credentialOldPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter old Password'**
  String get credentialOldPasswordPlaceholder;

  /// No description provided for @credentialNewPinTitle.
  ///
  /// In en, this message translates to:
  /// **'New PIN'**
  String get credentialNewPinTitle;

  /// No description provided for @credentialNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get credentialNewPasswordTitle;

  /// No description provided for @credentialNewPinPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter new PIN'**
  String get credentialNewPinPlaceholder;

  /// No description provided for @credentialNewPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter new Password'**
  String get credentialNewPasswordPlaceholder;

  /// No description provided for @credentialPinTitle.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get credentialPinTitle;

  /// No description provided for @credentialPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get credentialPasswordTitle;

  /// No description provided for @credentialPinPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get credentialPinPlaceholder;

  /// No description provided for @credentialPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get credentialPasswordPlaceholder;

  /// No description provided for @authenticatorProtectionStatusLastAttemptFailed.
  ///
  /// In en, this message translates to:
  /// **'Invalid credential was provided previously. Authenticator is unlocked. You have {retryCount} try left.\nPlease retry in {coolDown} seconds.'**
  String authenticatorProtectionStatusLastAttemptFailed(
      int retryCount, int coolDown);

  /// No description provided for @authenticatorProtectionStatusLocked.
  ///
  /// In en, this message translates to:
  /// **'Authenticator is locked.'**
  String get authenticatorProtectionStatusLocked;

  /// No description provided for @transactionConfirmationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction confirmation'**
  String get transactionConfirmationScreenTitle;

  /// No description provided for @confirmationScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Authenticate using {authenticator}'**
  String confirmationScreenDescription(String authenticator);

  /// No description provided for @confirmationScreenDescriptionFingerprintVerification.
  ///
  /// In en, this message translates to:
  /// **'Use Fingerprint sensor to authenticate.'**
  String get confirmationScreenDescriptionFingerprintVerification;

  /// No description provided for @operationFailedResultTitle.
  ///
  /// In en, this message translates to:
  /// **'{operation} failed!'**
  String operationFailedResultTitle(String operation);

  /// No description provided for @operationSucceededResultTitle.
  ///
  /// In en, this message translates to:
  /// **'{operation} succeeded!'**
  String operationSucceededResultTitle(String operation);

  /// No description provided for @operationTypeInit.
  ///
  /// In en, this message translates to:
  /// **'Init SDK'**
  String get operationTypeInit;

  /// No description provided for @operationTypeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get operationTypeRegistration;

  /// No description provided for @operationTypeAuthCloudApiRegistration.
  ///
  /// In en, this message translates to:
  /// **'Auth Cloud Registration'**
  String get operationTypeAuthCloudApiRegistration;

  /// No description provided for @operationTypeAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get operationTypeAuthentication;

  /// No description provided for @operationTypeDeregistration.
  ///
  /// In en, this message translates to:
  /// **'Deregistration'**
  String get operationTypeDeregistration;

  /// No description provided for @operationTypePinChange.
  ///
  /// In en, this message translates to:
  /// **'PIN change'**
  String get operationTypePinChange;

  /// No description provided for @operationTypePasswordChange.
  ///
  /// In en, this message translates to:
  /// **'Password change'**
  String get operationTypePasswordChange;

  /// No description provided for @operationTypeDeviceInformationChange.
  ///
  /// In en, this message translates to:
  /// **'Device information change'**
  String get operationTypeDeviceInformationChange;

  /// No description provided for @operationTypePayloadDecode.
  ///
  /// In en, this message translates to:
  /// **'Payload decode'**
  String get operationTypePayloadDecode;

  /// No description provided for @operationTypeLocalData.
  ///
  /// In en, this message translates to:
  /// **'Local Data operation'**
  String get operationTypeLocalData;

  /// No description provided for @operationTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Operation'**
  String get operationTypeUnknown;

  /// No description provided for @registrationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'In-Band Registration'**
  String get registrationScreenTitle;

  /// No description provided for @registrationUsernameTitle.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get registrationUsernameTitle;

  /// No description provided for @registrationUsernamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get registrationUsernamePlaceholder;

  /// No description provided for @registrationPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registrationPasswordTitle;

  /// No description provided for @registrationPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get registrationPasswordPlaceholder;

  /// No description provided for @changeDeviceInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Device Information'**
  String get changeDeviceInformationTitle;

  /// No description provided for @changeDeviceInformationCurrentName.
  ///
  /// In en, this message translates to:
  /// **'Current name: {currentName}'**
  String changeDeviceInformationCurrentName(String currentName);

  /// No description provided for @changeDeviceInformationNewName.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get changeDeviceInformationNewName;

  /// No description provided for @changeDeviceInformationEmptyCurrentName.
  ///
  /// In en, this message translates to:
  /// **'There is no name given to the device information currently!'**
  String get changeDeviceInformationEmptyCurrentName;

  /// No description provided for @authCloudApiRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Auth Cloud Registration'**
  String get authCloudApiRegistrationTitle;

  /// No description provided for @authCloudApiRegistrationEnrollResponse.
  ///
  /// In en, this message translates to:
  /// **'Enroll response'**
  String get authCloudApiRegistrationEnrollResponse;

  /// No description provided for @authCloudApiRegistrationAppLinkUri.
  ///
  /// In en, this message translates to:
  /// **'App Link Uri'**
  String get authCloudApiRegistrationAppLinkUri;

  /// No description provided for @authCloudApiRegistrationErrorMissingData.
  ///
  /// In en, this message translates to:
  /// **'Either the response or the appLinkUri is required.'**
  String get authCloudApiRegistrationErrorMissingData;

  /// No description provided for @authCloudApiRegistrationErrorWrongData.
  ///
  /// In en, this message translates to:
  /// **'You cannot provide both the response and the appLinkUri.'**
  String get authCloudApiRegistrationErrorWrongData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
