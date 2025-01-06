// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/extension/authenticator_extension.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/authenticator/authenticator_item.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/validation/authenticator_validator.dart';

enum Operation {
  registration,
  authentication,
}

abstract class AuthenticatorSelectorImpl implements AuthenticatorSelector {
  DomainBloc get domainBloc;
  ConfigurationLoader get configurationLoader;
  AuthenticatorValidator get authenticatorValidator;
  StateRepository<UserInteractionOperationState>
      get userInteractionOperationStateRepository;
  Operation get operation;

  @override
  void selectAuthenticator(
    AuthenticatorSelectionContext context,
    AuthenticatorSelectionHandler handler,
  ) async {
    debugPrint('Please select one of the received available authenticators!');

    final appConfiguration = await configurationLoader.appConfiguration();
    Set<Authenticator> authenticators = {};
    switch (operation) {
      case Operation.registration:
        authenticators = await authenticatorValidator.validateForRegistration(
          context,
          appConfiguration.authenticatorAllowlist,
        );
      case Operation.authentication:
        authenticators = authenticatorValidator.validateForAuthentication(
          context,
          appConfiguration.authenticatorAllowlist,
        );
    }

    if (authenticators.isEmpty) {
      debugPrint(
        'No available authenticators found. Cancelling authenticator selection.',
      );
      return handler.cancel();
    }

    Set<AuthenticatorItem> authenticatorItems = {};
    for (final item in authenticators) {
      authenticatorItems.add(
        AuthenticatorItem(
          aaid: item.aaid,
          isPolicyCompliant: await context.isPolicyCompliant(item.aaid),
          isUserEnrolled: item.isEnrolled(
            context.account.username,
            appConfiguration.allowClass2Sensors,
          ),
        ),
      );
    }

    userInteractionOperationStateRepository.save(
      UserInteractionOperationState(
        authenticatorSelectionContext: context,
        authenticatorSelectionHandler: handler,
      ),
    );

    domainBloc.add(SelectAuthenticatorEvent(
      authenticatorItems: authenticatorItems,
    ));
  }
}
