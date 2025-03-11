// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/collection_utils.dart';

abstract class AuthenticatorValidator {
  Future<Set<Authenticator>> validateForRegistration(
    AuthenticatorSelectionContext context,
    List<String> authenticatorAllowlist,
  );

  Set<Authenticator> validateForAuthentication(
    AuthenticatorSelectionContext context,
    List<String> authenticatorAllowlist,
  );
}

@Injectable(as: AuthenticatorValidator)
class AuthenticatorValidatorImpl implements AuthenticatorValidator {
  @override
  Future<Set<Authenticator>> validateForRegistration(
    AuthenticatorSelectionContext context,
    List<String> authenticatorAllowlist,
  ) {
    Set<Authenticator> allowedAuthenticators = _allowedAuthenticators(
      context,
      authenticatorAllowlist,
    );

    return whereAsync(allowedAuthenticators, (authenticator) async {
      // Do not display:
      //  - policy non-compliant authenticators (this includes already registered authenticators)
      //  - not hardware supported authenticators
      //  - not OS supported authenticators
      //  - prefer Biometrics authenticator on Android
      return authenticator.isSupportedByHardware &&
          authenticator.isSupportedByOs &&
          await context.isPolicyCompliant(authenticator.aaid) &&
          await _filterAndroidFingerprintIfNecessary(context, authenticator);
    });
  }

  @override
  Set<Authenticator> validateForAuthentication(
    AuthenticatorSelectionContext context,
    List<String> authenticatorAllowlist,
  ) {
    return _allowedAuthenticators(
      context,
      authenticatorAllowlist,
    ).where((authenticator) {
      // Do not display:
      //   - non-registered authenticators
      //   - not hardware supported authenticators
      return authenticator.registration
              .isRegistered(context.account.username) &&
          authenticator.isSupportedByHardware;
    }).toSet();
  }

  Set<Authenticator> _allowedAuthenticators(
    AuthenticatorSelectionContext context,
    List<String> authenticatorAllowlist,
  ) {
    return context.authenticators
        .where((a) => authenticatorAllowlist.contains(a.aaid))
        .toSet();
  }

  Future<bool> _filterAndroidFingerprintIfNecessary(
    AuthenticatorSelectionContext context,
    Authenticator authenticator,
  ) async {
    if (Platform.isIOS || !authenticator.aaid.isFingerprint) {
      return Future.value(true);
    }

    var isBiometricsRegistered = false;
    var canRegisterBiometrics = false;
    var canRegisterFingerprint = false;
    for (final authenticator in context.authenticators) {
      if (authenticator.aaid.isBiometric &&
          authenticator.registration.isRegistered(context.account.username)) {
        isBiometricsRegistered = true;
      }

      if (authenticator.aaid.isBiometric &&
          authenticator.isSupportedByHardware &&
          await context.isPolicyCompliant(authenticator.aaid)) {
        canRegisterBiometrics = true;
      }

      if (authenticator.aaid.isFingerprint &&
          authenticator.isSupportedByHardware &&
          await context.isPolicyCompliant(authenticator.aaid)) {
        canRegisterFingerprint = true;
      }
    }

    // If biometric can be registered (or is already registered), or if we
    // cannot register fingerprint, do not propose to register fingerprint
    // (we favor biometric over fingerprint).
    return !isBiometricsRegistered &&
        !canRegisterBiometrics &&
        canRegisterFingerprint;
  }
}
