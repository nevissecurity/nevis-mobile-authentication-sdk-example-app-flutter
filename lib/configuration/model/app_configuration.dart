// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/login_configuration.dart';

part 'app_configuration.g.dart';

@JsonSerializable()
class AppConfiguration {
  @JsonKey(name: "login")
  LoginConfiguration loginConfiguration;

  @JsonKey(name: "sdk")
  Configuration sdkConfiguration;

  AppConfiguration({
    required this.loginConfiguration,
    required this.sdkConfiguration,
  });

  factory AppConfiguration.fromJson(Map<String, dynamic> json) => _$AppConfigurationFromJson(json);

  AppConfiguration fromJson(Map<String, dynamic> json) => AppConfiguration.fromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigurationToJson(this);
}
