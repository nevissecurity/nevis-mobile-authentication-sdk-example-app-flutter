// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/datasource/deep_link/deep_link_platform_method_names.dart';

abstract class DeepLinkDataSource {
  StreamSubscription setDeepLinkReceiver(
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });

  Future<String?> getStartUri();
}

@Singleton(as: DeepLinkDataSource)
class DeepLinkDataSourceImpl implements DeepLinkDataSource {
  // Event Channel creation
  final _eventStream = const EventChannel(
      'nevis_mobile_authentication_sdk_example/deeplink_event_channel');

  // Method channel creation
  final _platform = const MethodChannel(
      'nevis_mobile_authentication_sdk_example/deeplink_method_channel');

  @override
  StreamSubscription setDeepLinkReceiver(void Function(dynamic)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _eventStream.receiveBroadcastStream().listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }

  @override
  Future<String?> getStartUri() async {
    try {
      return await _platform.invokeMethod(
        DeepLinkPlatformMethodNames.initialLink,
      );
    } on PlatformException catch (e) {
      return "Failed to invoke: '${e.message}'.";
    }
  }
}
