// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String status;
  final String extId;

  LoginResponse({
    required this.status,
    required this.extId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  LoginResponse fromJson(Map<String, dynamic> json) =>
      LoginResponse.fromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
