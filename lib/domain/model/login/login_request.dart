// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "isiwebuserid")
  final String username;

  @JsonKey(name: "isiwebpasswd")
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  LoginRequest fromJson(Map<String, dynamic> json) =>
      LoginRequest.fromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
