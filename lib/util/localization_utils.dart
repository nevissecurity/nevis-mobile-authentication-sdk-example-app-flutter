// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error_message_types.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';

extension AuthenticatorLocalizationExtension on String {
  String resolve(AppLocalizations localizations) {
    if (this == Aaid.pin.rawValue) {
      return localizations.authenticatorTitlePin;
    } else if (this == Aaid.biometric.rawValue) {
      if (Platform.isAndroid) {
        return localizations.authenticatorTitleBiometric;
      } else if (Platform.isIOS) {
        return localizations.authenticatorTitleFaceID;
      }
    } else if (this == Aaid.fingerprint.rawValue) {
      if (Platform.isAndroid) {
        return localizations.authenticatorTitleFingerprint;
      } else if (Platform.isIOS) {
        return localizations.authenticatorTitleTouchID;
      }
    } else if (this == Aaid.devicePasscode.rawValue) {
      return localizations.authenticatorTitleDevicePasscode;
    }

    return 'Unknown AAID: $this';
  }
}

extension AuthenticatorItemLocalizationExtension on AuthenticatorItem {
  String resolveDetails(AppLocalizations localizations) {
    if (isEnabled()) {
      return '';
    }

    if (!isPolicyCompliant) {
      return localizations.authenticatorNotPolicyCompliant;
    }

    if (!isUserEnrolled) {
      return localizations.authenticatorNotEnrolled;
    }

    return '';
  }
}

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
      case OperationType.localData:
        return localizations.operationTypeLocalData;
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
        return localizations
            .businessErrorTypeMissingOpenSettingsOperationForUser;
      case BusinessErrorType.pinAuthenticatorNotFound:
        return localizations.businessErrorTypePinAuthenticatorNotFound;
      case BusinessErrorType.registeredAccountsNotFound:
        return localizations.businessErrorTypeRegisteredAccountsNotFound;
    }
  }
}
