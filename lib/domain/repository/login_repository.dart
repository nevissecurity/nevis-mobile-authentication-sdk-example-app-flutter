// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/credentials.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/login_request.dart';

abstract class LoginRepository {
  Future<Credentials> login({
    required Uri uri,
    required LoginRequest loginRequest,
  });
}
