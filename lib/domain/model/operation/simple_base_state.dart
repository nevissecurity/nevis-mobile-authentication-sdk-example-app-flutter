// Copyright © 2022 Nevis Security AG. All rights reserved.

abstract class SimpleBaseState<C, H> {
  C get context;

  H get handler;

  Future<void> cancel();
}
