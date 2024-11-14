// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/device_information_usecase.dart';

abstract class CreateDeviceInformationUseCase {
  Future<DeviceInformation> execute();
}

@Injectable(as: CreateDeviceInformationUseCase)
class CreateDeviceInformationUseCaseImpl
    implements CreateDeviceInformationUseCase {
  final DeviceInformationUseCase _deviceInformationUseCase;
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  CreateDeviceInformationUseCaseImpl(
    this._deviceInformationUseCase,
  );

  @override
  Future<DeviceInformation> execute() async {
    // If there is a device name already set in the SDK then use that one,
    // otherwise create a new one.
    final deviceInformation = await _deviceInformationUseCase.execute();
    final deviceName = deviceInformation?.name ?? await _getDeviceName();
    return Future.value(DeviceInformation(name: deviceName));
  }

  Future<String> _getDeviceName() async {
    String? deviceName;
    String osPrefix = '';
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      osPrefix = 'Android';
      deviceName = "${androidInfo.manufacturer} ${androidInfo.model}";
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      osPrefix = 'iOS';
      deviceName = iosInfo.name;
    }
    deviceName = deviceName?.trim();
    deviceName =
        deviceName == null || deviceName.isEmpty ? "Unknown" : deviceName;
    final dateFormat = DateFormat('dd.MM.yyyy kk:mm:sss');
    final formattedDate = dateFormat.format(DateTime.now());
    return '$osPrefix $deviceName-$formattedDate';
  }
}
