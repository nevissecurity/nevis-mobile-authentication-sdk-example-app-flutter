// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/extension/authenticator_extension.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/collection_utils.dart';

@Named("auth_selector_reg")
@Injectable(as: AuthenticatorSelector)
class RegistrationAuthenticatorSelectorImpl implements AuthenticatorSelector {
  final DomainBloc _domainBloc;
  final ConfigurationLoader _configurationLoader;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  RegistrationAuthenticatorSelectorImpl(
    this._domainBloc,
    this._configurationLoader,
    this._userInteractionOperationStateRepository,
  );

  @override
  void selectAuthenticator(
    AuthenticatorSelectionContext context,
    AuthenticatorSelectionHandler handler,
  ) async {
    debugPrint('Please select one of the received available authenticators!');

    Set<Authenticator> authenticators =
        await whereAsync(context.authenticators, (authenticator) async {
      return _mustDisplayForRegistration(authenticator, context);
    });

    final configuration = await _configurationLoader.load();
    final username = context.account.username;
    Set<AuthenticatorItem> authenticatorItems = {};
    for (final item in authenticators) {
      authenticatorItems.add(
        AuthenticatorItem(
          aaid: item.aaid,
          isPolicyCompliant: await context.isPolicyCompliant(item.aaid),
          isUserEnrolled: item.isEnrolled(
            username,
            configuration.allowClass2Sensors,
          ),
        ),
      );
    }

    _userInteractionOperationStateRepository.save(
      UserInteractionOperationState(
        authenticatorSelectionContext: context,
        authenticatorSelectionHandler: handler,
      ),
    );

    _domainBloc.add(SelectAuthenticatorEvent(
      authenticatorItems: authenticatorItems,
    ));
  }

  Future<bool> _mustDisplayForRegistration(Authenticator authenticator,
      AuthenticatorSelectionContext context) async {
    if (Platform.isAndroid) {
      final username = context.account.username;
      final authenticators = context.authenticators;
      final isBiometricRegistered = await anyAsync(
        authenticators,
        (Authenticator a) => Future.value(
          a.aaid.isBiometric && a.registration.isRegistered(username),
        ),
      );
      final canRegisterBiometric =
          await anyAsync(authenticators, (Authenticator a) async {
        return Future.value(
          a.aaid.isBiometric &&
              await context.isPolicyCompliant(a.aaid) &&
              a.isSupportedByHardware,
        );
      });
      final canRegisterFingerprint =
          await anyAsync(authenticators, (Authenticator a) async {
        return Future.value(
          a.aaid.isFingerprint &&
              await context.isPolicyCompliant(a.aaid) &&
              a.isSupportedByHardware,
        );
      });

      // If biometric can be registered (or is already registered), or if we
      // cannot register fingerprint, do not propose to register fingerprint
      // (we favor biometric over fingerprint).
      if ((canRegisterBiometric ||
              isBiometricRegistered ||
              !canRegisterFingerprint) &&
          authenticator.aaid.isFingerprint) {
        return Future.value(false);
      }
    }

    // Do not display:
    //  - policy non-compliant authenticators (this includes already registered authenticators)
    //  - not hardware supported authenticators
    return Future.value(authenticator.isSupportedByHardware &&
        await context.isPolicyCompliant(authenticator.aaid));
  }
}
