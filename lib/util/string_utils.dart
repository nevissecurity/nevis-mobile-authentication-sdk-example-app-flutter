// Copyright © 2022 Nevis Security AG. All rights reserved.

extension NullableStringExtensions<E> on String? {
  /// Returns `true` if this string is `null` or empty.
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }

  /// Returns `true` if this string is not `null` and not empty.
  bool get isNotNullNorEmpty {
    return this?.isNotEmpty ?? false;
  }
}
