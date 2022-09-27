// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

abstract class DeepLinkRepository {
  StreamSubscription setDeepLinkReceiver(
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });

  Future<String?> getStartUri();
}
