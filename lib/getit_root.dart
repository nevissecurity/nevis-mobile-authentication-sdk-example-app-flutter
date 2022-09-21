// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/getit_root.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
// acceptable values for environment parameter are cloud & onPremise
void configureDependencies() => $initGetIt(getIt, environment: 'onPremise');
