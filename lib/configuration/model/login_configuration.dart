// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'login_configuration.g.dart';

@JsonSerializable()
class LoginConfiguration {
  String loginRequestURL;

  LoginConfiguration(this.loginRequestURL);

  factory LoginConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LoginConfigurationFromJson(json);

  LoginConfiguration fromJson(Map<String, dynamic> json) =>
      LoginConfiguration.fromJson(json);

  Map<String, dynamic> toJson() => _$LoginConfigurationToJson(this);
}
