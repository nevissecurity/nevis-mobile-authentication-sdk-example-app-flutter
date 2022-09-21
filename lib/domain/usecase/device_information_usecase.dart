// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';

abstract class DeviceInformationUseCase {
  Future<DeviceInformation?> execute();
}

@Injectable(as: DeviceInformationUseCase)
class DeviceInformationUseCaseImpl implements DeviceInformationUseCase {
  final ClientProvider _clientProvider;

  DeviceInformationUseCaseImpl(this._clientProvider);

  @override
  Future<DeviceInformation?> execute() async {
    return await _clientProvider.client.localData.deviceInformation;
  }
}
