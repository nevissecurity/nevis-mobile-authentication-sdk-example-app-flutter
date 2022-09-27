// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';

abstract class AuthenticatorsUseCase {
  Future<Set<Authenticator>> execute();
}

@Injectable(as: AuthenticatorsUseCase)
class AuthenticatorsUseCaseImpl implements AuthenticatorsUseCase {
  final ClientProvider _clientProvider;

  AuthenticatorsUseCaseImpl(this._clientProvider);

  @override
  Future<Set<Authenticator>> execute() async {
    return await _clientProvider.client.localData.authenticators;
  }
}
