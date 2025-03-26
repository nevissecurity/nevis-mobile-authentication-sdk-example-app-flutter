// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/app_configuration.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/app_environment.dart';

const authenticationCloud = Environment('authenticationCloud');
const identitySuite = Environment('identitySuite');

abstract class ConfigurationLoader {
  AppEnvironment get environment;

  AppConfiguration? _appConfiguration;
  Configuration? _sdkConfiguration;

  Future<AppConfiguration> appConfiguration() async {
    if (_appConfiguration != null) {
      return Future.value(_appConfiguration);
    }

    final configFile = environment.configFileName;
    final jsonString = await rootBundle.loadString('assets/$configFile');
    final dynamic jsonMap = jsonDecode(jsonString);
    _appConfiguration = AppConfiguration.fromJson(jsonMap);
    return Future.value(_appConfiguration);
  }

  Future<Configuration> sdkConfiguration() async {
    if (_sdkConfiguration != null) {
      return Future.value(_sdkConfiguration);
    }

    final appConfiguration = await this.appConfiguration();
    switch (environment) {
      case AppEnvironment.authenticationCloud:
        _sdkConfiguration = Configuration.authCloudBuilder()
            .hostname(appConfiguration.sdk.hostname)
            .facetId(appConfiguration.sdk.facetId)
            .build();
      case AppEnvironment.identitySuite:
        _sdkConfiguration = Configuration.admin4PatternBuilder()
            .hostname(appConfiguration.sdk.hostname)
            .facetId(appConfiguration.sdk.facetId)
            .build();
    }

    return Future.value(_sdkConfiguration!);
  }
}

@authenticationCloud
@Singleton(as: ConfigurationLoader)
class AuthenticationCloudConfigurationLoader extends ConfigurationLoader {
  AuthenticationCloudConfigurationLoader();

  @override
  AppEnvironment get environment => AppEnvironment.authenticationCloud;
}

@identitySuite
@Singleton(as: ConfigurationLoader)
class IdentitySuiteConfigurationLoader extends ConfigurationLoader {
  IdentitySuiteConfigurationLoader();

  @override
  AppEnvironment get environment => AppEnvironment.identitySuite;
}
