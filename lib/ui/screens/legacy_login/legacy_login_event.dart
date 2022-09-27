// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class LegacyLoginEvent {}

class ConfirmEvent extends LegacyLoginEvent {
  final String username;
  final String password;

  ConfirmEvent({required this.username, required this.password});
}
