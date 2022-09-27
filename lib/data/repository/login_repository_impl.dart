// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/datasource/login/login_datasource.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/credentials.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/login_request.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;

  LoginRepositoryImpl(this._loginDataSource);

  @override
  Future<Credentials> login({
    required Uri uri,
    required LoginRequest loginRequest,
  }) async {
    return await _loginDataSource.login(uri: uri, loginRequest: loginRequest);
  }
}
