// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

mixin BehaviorSubjectMixin<E, S> on Bloc<E, S> {
  StreamSubscription<S> listen(
    void Function(S state) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    onData(state);
    return super.stream.listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }
}
