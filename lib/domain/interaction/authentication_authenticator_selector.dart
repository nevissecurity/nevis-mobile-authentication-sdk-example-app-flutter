// Copyright © 2022 Nevis Security AG. All rights reserved.

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

@Named("auth_selector_auth")
@Injectable(as: AuthenticatorSelector)
class AuthenticationAuthenticatorSelectorImpl implements AuthenticatorSelector {
  final DomainBloc _domainBloc;
  final ConfigurationLoader _configurationLoader;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  AuthenticationAuthenticatorSelectorImpl(
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

    final username = context.account.username;
    List<Authenticator> authenticators = context.authenticators
        .where((a) =>
            // Do not display:
            //   - non-registered authenticators
            //   - not hardware supported authenticators
            a.registration.isRegistered(username) && a.isSupportedByHardware)
        .toList();

    final configuration = await _configurationLoader.load();
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
}
