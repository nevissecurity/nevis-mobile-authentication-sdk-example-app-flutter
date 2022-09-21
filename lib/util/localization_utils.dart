// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error_message_types.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

extension OperationTypeLocalizationExtension on OperationType {
  String resolve(AppLocalizations localizations) {
    switch (this) {
      case OperationType.init:
        return localizations.operationTypeInit;
      case OperationType.registration:
        return localizations.operationTypeRegistration;
      case OperationType.authCloudApiRegistration:
        return localizations.operationTypeAuthCloudApiRegistration;
      case OperationType.authentication:
        return localizations.operationTypeAuthentication;
      case OperationType.deregistration:
        return localizations.operationTypeDeregistration;
      case OperationType.pinChange:
        return localizations.operationTypePinChange;
      case OperationType.deviceInformationChange:
        return localizations.operationTypeDeviceInformationChange;
      case OperationType.payloadDecode:
        return localizations.operationTypePayloadDecode;
      case OperationType.unknown:
        return localizations.operationTypeUnknown;
    }
  }
}

extension BusinessErrorTypeLocalizationExtension on BusinessErrorType {
  String resolve(AppLocalizations localizations) {
    switch (this) {
      case BusinessErrorType.accountsNotFound:
        return localizations.businessErrorTypeAccountsNotFound;
      case BusinessErrorType.authenticatorNotFound:
        return localizations.businessErrorTypeAuthenticatorNotFound;
      case BusinessErrorType.deviceInformationNotFound:
        return localizations.businessErrorTypeDispatchTargetNotFound;
      case BusinessErrorType.invalidState:
        return localizations.businessErrorTypeInvalidState;
      case BusinessErrorType.missingCookie:
        return localizations.businessErrorTypeMissingCookie;
      case BusinessErrorType.missingDispatchTokenResponse:
        return localizations.businessErrorTypeMissingDispatchTokenResponse;
      case BusinessErrorType.missingOpenSettingsOperationForUser:
        return localizations.businessErrorTypeMissingOpenSettingsOperationForUser;
      case BusinessErrorType.pinAuthenticatorNotFound:
        return localizations.businessErrorTypePinAuthenticatorNotFound;
      case BusinessErrorType.registeredAccountsNotFound:
        return localizations.businessErrorTypeRegisteredAccountsNotFound;
    }
  }
}

extension RecoverableErrorTypeExtension on RecoverableError {
  String? resolve(AppLocalizations localizations) {
    if (this is PinUserVerificationInvalidPinError) {
      return localizations.pinUserVerificationInvalidPinError;
    } else if (this is PinChangeRecoverableInvalidPin) {
      return localizations.pinChangeRecoverableInvalidPin;
    } else if (this is PinChangeRecoverableInvalidPinFormat) {
      return localizations.pinChangeRecoverableInvalidPinFormat;
    } else if (this is PinChangeRecoverableOldPinEqualsNewPin) {
      return localizations.pinChangeRecoverableOldPinEqualsNewPin;
    } else if (this is FingerprintUserVerificationError) {
      return localizations.fingerprintUserVerificationError;
    } else if (this is PinEnrollmentInvalidPinFormat) {
      return localizations.pinEnrollmentInvalidPinFormat;
    }
    return null;
  }
}
