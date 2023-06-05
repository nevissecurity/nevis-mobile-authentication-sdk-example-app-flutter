// Copyright © 2023 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

extension Utility on Authenticator {
  bool isEnrolled(String username, bool allowClass2Sensors) {
    if (userEnrollment is OsUserEnrollment) {
      final osUserEnrollment = userEnrollment as OsUserEnrollment;
      if (allowClass2Sensors) {
        return osUserEnrollment.isEnrolledWithClass2OrClass3Sensor ?? false;
      } else {
        return osUserEnrollment.isEnrolled(username);
      }
    } else if (userEnrollment is SdkUserEnrollment) {
      final sdkUserEnrollment = userEnrollment as SdkUserEnrollment;
      return sdkUserEnrollment.isEnrolled(username);
    } else {
      return false;
    }
  }
}
