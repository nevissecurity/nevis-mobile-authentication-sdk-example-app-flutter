// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class Cache<T> {
  void put(T item);

  T? get item;

  void clear();
}

class CacheImpl<T> implements Cache<T> {
  T? _item;

  @override
  void clear() {
    _item = null;
  }

  @override
  void put(T item) {
    _item = item;
  }

  @override
  T? get item => _item;
}
