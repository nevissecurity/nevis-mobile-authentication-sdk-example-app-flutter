// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/app_configuration.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/configuration/model/app_environment.dart';

const cloud = Environment('cloud');
const onPremise = Environment('onPremise');

abstract class ConfigurationLoader {
  AppEnvironment get environment;
  AppConfiguration? configuration;

  Future<AppConfiguration> load() async {
    if (configuration != null) return Future.value(configuration);

    final configFile = environment.configFileName;
    final jsonString = await rootBundle.loadString('assets/$configFile');
    final dynamic jsonMap = jsonDecode(jsonString);
    configuration = AppConfiguration.fromJson(jsonMap);
    return Future.value(configuration);
  }
}

@cloud
@Singleton(as: ConfigurationLoader)
class CloudConfigurationLoader extends ConfigurationLoader {
  CloudConfigurationLoader();

  @override
  AppEnvironment get environment => AppEnvironment.cloud;
}

@onPremise
@Singleton(as: ConfigurationLoader)
class OnPremiseConfigurationLoader extends ConfigurationLoader {
  OnPremiseConfigurationLoader();

  @override
  AppEnvironment get environment => AppEnvironment.onPremise;
}
