// Copyright © 2022 Nevis Security AG. All rights reserved.

/// Async implementation of **where** method of [Set] class.
///
/// It needs a [Set] object and a condition lambda as parameters.
Future<Set<T>> whereAsync<T>(Set<T> elements, Future<bool> Function(T) condition) async {
  final result = <T>{};
  for (var element in elements) {
    if (await condition(element)) {
      result.add(element);
    }
  }
  return Future.value(result);
}

/// Async implementation of **any** method of [Set] class.
///
/// It needs a [Set] object and a condition lambda as parameters.
Future<bool> anyAsync<T>(Set<T> elements, Future<bool> Function(T) condition) async {
  for (var element in elements) {
    if (await condition(element)) {
      return Future.value(true);
    }
  }
  return Future.value(false);
}
