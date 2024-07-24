// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/configuration_loader.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/interaction/authenticator_selector_impl.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/user_interaction_operation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/validation/authenticator_validator.dart';

@Named("auth_selector_reg")
@Injectable(as: AuthenticatorSelector)
class RegistrationAuthenticatorSelectorImpl extends AuthenticatorSelectorImpl {
  final DomainBloc _domainBloc;
  final ConfigurationLoader _configurationLoader;
  final AuthenticatorValidator _authenticatorValidator;
  final StateRepository<UserInteractionOperationState>
      _userInteractionOperationStateRepository;

  RegistrationAuthenticatorSelectorImpl(
    this._domainBloc,
    this._configurationLoader,
    this._authenticatorValidator,
    this._userInteractionOperationStateRepository,
  );

  @override
  DomainBloc get domainBloc => _domainBloc;

  @override
  ConfigurationLoader get configurationLoader => _configurationLoader;

  @override
  AuthenticatorValidator get authenticatorValidator => _authenticatorValidator;

  @override
  StateRepository<UserInteractionOperationState>
      get userInteractionOperationStateRepository =>
          _userInteractionOperationStateRepository;

  @override
  Operation get operation => Operation.registration;
}
