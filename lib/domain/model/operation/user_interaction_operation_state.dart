// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

class UserInteractionOperationState {
  AuthenticatorSelectionContext? authenticatorSelectionContext;
  AuthenticatorSelectionHandler? authenticatorSelectionHandler;
  UserVerificationHandler? userVerificationHandler;
  OsAuthenticationListenHandler? osAuthenticationListenHandler;
  AccountSelectionHandler? accountSelectionHandler;

  UserInteractionOperationState({
    this.authenticatorSelectionContext,
    this.authenticatorSelectionHandler,
    this.userVerificationHandler,
    this.osAuthenticationListenHandler,
    this.accountSelectionHandler,
  });

  UserInteractionOperationState copyWith({
    required AccountSelectionHandler? accountSelectionHandler,
    required AuthenticatorSelectionHandler? authenticatorSelectionHandler,
    UserVerificationHandler? userVerificationHandler,
    OsAuthenticationListenHandler? osAuthenticationListenHandler,
  }) =>
      UserInteractionOperationState(
        accountSelectionHandler: accountSelectionHandler,
        authenticatorSelectionContext: authenticatorSelectionContext,
        authenticatorSelectionHandler:
            authenticatorSelectionHandler ?? this.authenticatorSelectionHandler,
        userVerificationHandler:
            userVerificationHandler ?? this.userVerificationHandler,
        osAuthenticationListenHandler:
            osAuthenticationListenHandler ?? this.osAuthenticationListenHandler,
      );
}
