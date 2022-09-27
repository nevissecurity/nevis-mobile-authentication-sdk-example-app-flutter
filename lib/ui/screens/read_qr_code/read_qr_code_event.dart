// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class ReadQrCodeEvent {}

class QrCodeScannedEvent extends ReadQrCodeEvent {
  final String content;

  QrCodeScannedEvent(this.content);
}
