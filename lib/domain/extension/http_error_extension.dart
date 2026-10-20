// Copyright © 2026 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/extension/response_headers_extension.dart';

extension Utility on HttpError {
  String asString() {
    return """
      HttpError
          Status code: $statusCode
          Request url: $requestUrl
          Body: $body
          Headers: 
              ${headers?.asString()}
          Method: $method
          Underlying: $underlying
    """;
  }
}
