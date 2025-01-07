// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sdk_configuration.g.dart';

@JsonSerializable()
class SdkConfiguration {
  String? baseUrl;
  String? hostname;
  String? facetId;
  String? registrationRequestPath;
  String? registrationResponsePath;
  String? authenticationRequestPath;
  String? authenticationResponsePath;
  String? deregistrationRequestPath;
  String? dispatchTargetResourcePath;
  String? deviceResourcePath;

  SdkConfiguration(
    this.baseUrl,
    this.hostname,
    this.facetId,
    this.registrationRequestPath,
    this.registrationResponsePath,
    this.authenticationRequestPath,
    this.authenticationResponsePath,
    this.deregistrationRequestPath,
    this.dispatchTargetResourcePath,
    this.deviceResourcePath,
  );

  factory SdkConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SdkConfigurationFromJson(json);

  SdkConfiguration fromJson(Map<String, dynamic> json) =>
      SdkConfiguration.fromJson(json);

  Map<String, dynamic> toJson() => _$SdkConfigurationToJson(this);
}
