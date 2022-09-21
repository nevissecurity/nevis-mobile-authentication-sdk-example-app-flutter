// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/cupertino.dart';

@immutable
abstract class ChangeDeviceInformationState {}

@immutable
class ChangeDeviceInformationInitial extends ChangeDeviceInformationState {}

class ChangeDeviceInformationLoaded extends ChangeDeviceInformationState {
  final String? deviceInformationCurrentName;

  ChangeDeviceInformationLoaded(this.deviceInformationCurrentName);
}
