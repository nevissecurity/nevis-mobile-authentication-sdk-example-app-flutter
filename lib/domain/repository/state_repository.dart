// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class StateRepository<T> {
  void save(T state);

  T? get state;

  void reset();
}
