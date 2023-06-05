// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/login_configuration.dart';

part 'app_configuration.g.dart';

@JsonSerializable()
class AppConfiguration {
  /// Specifies whether <a href="https://source.android.com/docs/security/features/biometric/measure#biometric-classes">
  /// Class 2 (formerly weak)</a> biometric sensors are allowed if the biometric
  /// authenticator is selected.
  ///
  /// By default the SDK will only allow to use Class 3 (formerly strong) sensors.
  /// Using Class 2 sensors is less secure and discouraged.
  /// When a Class 2 sensor is used, the FIDO UAF keys are not protected by the
  /// operating system by requiring user authentication.
  ///
  /// If the SDK detects that only Class 3 (strong) biometric sensors are available
  /// in the mobile device, even if Class 2 sensors are allowed, the FIDO UAF credentials
  /// will be protected by the operating system by requiring user authentication.
  ///
  /// However in some cases it may be acceptable for the sake of end-user convenience.
  /// Allowing Class 2 sensors will enable for instance the use of face recognition
  /// in some Samsung devices.
  bool allowClass2Sensors;

  @JsonKey(name: "login")
  LoginConfiguration loginConfiguration;

  @JsonKey(name: "sdk")
  Configuration sdkConfiguration;

  AppConfiguration({
    required this.allowClass2Sensors,
    required this.loginConfiguration,
    required this.sdkConfiguration,
  });

  factory AppConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AppConfigurationFromJson(json);

  AppConfiguration fromJson(Map<String, dynamic> json) =>
      AppConfiguration.fromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigurationToJson(this);
}
