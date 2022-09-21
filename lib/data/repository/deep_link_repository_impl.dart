// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/data/datasource/deep_link/deep_link_datasource.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/deep_link_repository.dart';

@Injectable(as: DeepLinkRepository)
class DeepLinkRepositoryImpl implements DeepLinkRepository {
  final DeepLinkDataSource _deepLinkDataSource;

  DeepLinkRepositoryImpl(this._deepLinkDataSource);

  @override
  StreamSubscription setDeepLinkReceiver(void Function(dynamic)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _deepLinkDataSource.setDeepLinkReceiver(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<String?> getStartUri() async {
    return await _deepLinkDataSource.getStartUri();
  }
}
