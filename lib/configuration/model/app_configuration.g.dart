// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfiguration _$AppConfigurationFromJson(Map<String, dynamic> json) => AppConfiguration(
      loginConfiguration: LoginConfiguration.fromJson(json['login'] as Map<String, dynamic>),
      sdkConfiguration: Configuration.fromJson(json['sdk'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppConfigurationToJson(AppConfiguration instance) => <String, dynamic>{
      'login': instance.loginConfiguration.toJson(),
      'sdk': instance.sdkConfiguration.toJson(),
    };
