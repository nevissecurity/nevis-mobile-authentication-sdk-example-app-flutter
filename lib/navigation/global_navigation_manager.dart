// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/navigation/auth_cloud_api_registration_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/navigation/change_device_information_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/navigation/confirmation_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/navigation/confirmation_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/navigation/home_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/navigation/legacy_login_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/navigation/read_qr_code_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_route.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_route.dart';

@singleton
class GlobalNavigationManager {
  GlobalKey<NavigatorState>? _navigatorKey;

  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  BuildContext? get navigatorContext => _navigatorKey?.currentContext;

  Future<dynamic>? pushHome() {
    return _navigatorKey?.currentState?.popAndPushNamed(HomeRoute.home);
  }

  void popUntilHome() {
    return _navigatorKey?.currentState
        ?.popUntil((route) => route.settings.name == HomeRoute.home);
  }

  Future<dynamic>? pushReadQrCode() {
    return _navigatorKey?.currentState?.pushNamed(ReadQrCodeRoute.readQrCode);
  }

  Future<dynamic>? pushLegacyLogin() {
    return _navigatorKey?.currentState?.pushNamed(LegacyLoginRoute.legacyLogin);
  }

  Future<dynamic>? pushPin(PinParameter parameter) {
    return _navigatorKey?.currentState?.pushNamed(
      PinRoute.pin,
      arguments: parameter,
    );
  }

  Future<dynamic>? pushSelectAccount(SelectAccountParameter parameter) {
    return _navigatorKey?.currentState?.pushNamed(
      SelectAccountRoute.selectAccount,
      arguments: parameter,
    );
  }

  Future<dynamic>? pushSelectAuthenticator(
    SelectAuthenticatorParameter parameter,
  ) {
    return _navigatorKey?.currentState?.pushNamed(
      SelectAuthenticatorRoute.selectAuthenticator,
      arguments: parameter,
    );
  }

  Future<dynamic>? pushTransactionConfirmation(
    TransactionConfirmationParameter parameter,
  ) {
    return _navigatorKey?.currentState?.pushNamed(
      TransactionConfirmationRoute.transactionConfirmation,
      arguments: parameter,
    );
  }

  Future<dynamic>? pushConfirmation(ConfirmationParameter parameter) {
    return _navigatorKey?.currentState?.pushNamed(
      ConfirmationRoute.confirmation,
      arguments: parameter,
    );
  }

  Future<dynamic>? pushResult(ResultParameter parameter) {
    return _navigatorKey?.currentState?.pushNamed(
      ResultRoute.result,
      arguments: parameter,
    );
  }

  Future<dynamic>? pushChangeDeviceInformation() {
    return _navigatorKey?.currentState?.pushNamed(
      ChangeDeviceInformationRoute.changeDeviceInformation,
    );
  }

  Future<dynamic>? pushAuthCloudApiRegistration() {
    return _navigatorKey?.currentState?.pushNamed(
      AuthCloudApiRegistrationRoute.authCloudApiRegistration,
    );
  }
}
