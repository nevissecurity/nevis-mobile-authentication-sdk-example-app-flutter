// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class ChangeDeviceInformationEvent {}

class ChangeDeviceInformationScreenCreated extends ChangeDeviceInformationEvent {}

class ChangeConfirmedEvent extends ChangeDeviceInformationEvent {
  final String newName;

  ChangeConfirmedEvent(this.newName);
}

class ChangeCancelledEvent extends ChangeDeviceInformationEvent {}
