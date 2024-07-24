// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/navigation/auth_cloud_api_registration_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/navigation/change_device_information_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/navigation/confirmation_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/navigation/credential_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/navigation/home_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/navigation/legacy_login_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/navigation/read_qr_code_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_route.dart';

@singleton
class AppNavigation {
  static const String initialRoute = HomeRoute.home;

  Map<String, WidgetBuilder> get routes => {}
    ..addAll(HomeRoute().routes)
    ..addAll(ReadQrCodeRoute().routes)
    ..addAll(CredentialRoute().routes)
    ..addAll(SelectAuthenticatorRoute().routes)
    ..addAll(SelectAccountRoute().routes)
    ..addAll(TransactionConfirmationRoute().routes)
    ..addAll(ConfirmationRoute().routes)
    ..addAll(ResultRoute().routes)
    ..addAll(LegacyLoginRoute().routes)
    ..addAll(ChangeDeviceInformationRoute().routes)
    ..addAll(AuthCloudApiRegistrationRoute().routes);
}
