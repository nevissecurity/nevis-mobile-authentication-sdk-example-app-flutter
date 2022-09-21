// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/collection_utils.dart';

@Injectable(as: AuthenticatorSelector)
class AuthenticatorSelectorImpl implements AuthenticatorSelector {
  final DomainBloc _domainBloc;
  final StateRepository<UserInteractionOperationState> _userInteractionOperationStateRepository;
  final StateRepository<OperationType> _operationTypeRepository;

  AuthenticatorSelectorImpl(
    this._domainBloc,
    this._userInteractionOperationStateRepository,
    this._operationTypeRepository,
  );

  @override
  void selectAuthenticator(AuthenticatorSelectionContext context, AuthenticatorSelectionHandler handler) async {
    Set<Authenticator> authenticators = await whereAsync(context.authenticators, (a) async {
      return _mustDisplay(a, context);
    });

    _userInteractionOperationStateRepository.save(UserInteractionOperationState(
      authenticatorSelectionContext: context,
      authenticatorSelectionHandler: handler,
    ));

    _domainBloc.add(SelectAuthenticatorEvent(authenticators: authenticators));
  }

  Future<bool> _mustDisplay(Authenticator authenticator, AuthenticatorSelectionContext context) async {
    final operation = _operationTypeRepository.state ?? OperationType.registration;
    final username = context.account.username;
    final isRegistered = authenticator.registration.isRegistered(username);

    switch (operation) {
      case OperationType.registration:
      case OperationType.authCloudApiRegistration:
        return Future.value(_mustDisplayForRegistration(authenticator, context));
      case OperationType.authentication:
      case OperationType.deregistration:
        return Future.value(isRegistered && authenticator.isSupportedByHardware);
      default:
        return Future.value(false);
    }
  }

  Future<bool> _mustDisplayForRegistration(Authenticator authenticator, AuthenticatorSelectionContext context) async {
    if (Platform.isAndroid) {
      final username = context.account.username;
      final authenticators = context.authenticators;
      final biometricRegistered = await anyAsync(authenticators,
          (Authenticator a) => Future.value(authenticator.aaid.isBiometric && a.registration.isRegistered(username)));
      final canRegisterBiometric = await anyAsync(authenticators, (Authenticator a) async {
        return Future.value(a.aaid.isBiometric && await context.isPolicyCompliant(a.aaid));
      });
      final canRegisterFingerprint = await anyAsync(authenticators, (Authenticator a) async {
        return Future.value(a.aaid.isFingerprint && await context.isPolicyCompliant(a.aaid));
      });

      // If biometric can be registered (or is already registered), or if we cannot
      // register fingerprint, do not propose to register fingerprint (we favor biometric over fingerprint).
      if ((canRegisterBiometric || biometricRegistered || !canRegisterFingerprint) &&
          authenticator.aaid.isFingerprint) {
        return Future.value(false);
      }

      // Do not display policy non-compliant authenticators (this includes already registered
      // authenticators), nor those not supported by hardware.
      return Future.value(authenticator.isSupportedByHardware && await context.isPolicyCompliant(authenticator.aaid));
    }
    return Future.value(true);
  }
}
