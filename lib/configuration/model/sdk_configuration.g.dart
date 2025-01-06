// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SdkConfiguration _$SdkConfigurationFromJson(Map<String, dynamic> json) =>
    SdkConfiguration(
      json['baseUrl'] as String?,
      json['hostname'] as String?,
      json['facetId'] as String?,
      json['registrationRequestPath'] as String?,
      json['registrationResponsePath'] as String?,
      json['authenticationRequestPath'] as String?,
      json['authenticationResponsePath'] as String?,
      json['deregistrationRequestPath'] as String?,
      json['dispatchTargetResourcePath'] as String?,
      json['deviceResourcePath'] as String?,
    );

Map<String, dynamic> _$SdkConfigurationToJson(SdkConfiguration instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'hostname': instance.hostname,
      'facetId': instance.facetId,
      'registrationRequestPath': instance.registrationRequestPath,
      'registrationResponsePath': instance.registrationResponsePath,
      'authenticationRequestPath': instance.authenticationRequestPath,
      'authenticationResponsePath': instance.authenticationResponsePath,
      'deregistrationRequestPath': instance.deregistrationRequestPath,
      'dispatchTargetResourcePath': instance.dispatchTargetResourcePath,
      'deviceResourcePath': instance.deviceResourcePath,
    };
