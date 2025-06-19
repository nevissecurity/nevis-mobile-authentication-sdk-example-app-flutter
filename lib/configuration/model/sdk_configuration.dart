// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sdk_configuration.g.dart';

@JsonSerializable()
class SdkConfiguration {
  String hostname;

  SdkConfiguration(
    this.hostname,
  );

  factory SdkConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SdkConfigurationFromJson(json);

  SdkConfiguration fromJson(Map<String, dynamic> json) =>
      SdkConfiguration.fromJson(json);

  Map<String, dynamic> toJson() => _$SdkConfigurationToJson(this);
}
