// Copyright © 2026 Nevis Security AG. All rights reserved.

import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';

extension Utility on MobileAuthenticationClientError {
  Server? get server => switch (this) {
    AuthCloudApiClockSkewTooBig(:final server) => server,
    AuthCloudApiNetworkError(:final server) => server,
    AuthenticationNetworkError(:final server) => server,
    DeviceInformationChangeClockSkewTooBig(:final server) => server,
    DeviceInformationChangeNameAlreadyExists(:final server) => server,
    DeviceInformationChangeNetworkError(:final server) => server,
    DeviceInformationChangeNotFound(:final server) => server,
    DeviceInformationCheckClockSkewTooBig(:final server) => server,
    DeviceInformationCheckForbidden(:final server) => server,
    DeviceInformationCheckNetworkError(:final server) => server,
    DeviceInformationCheckOperationNotSupportedByBackend(:final server) =>
      server,
    DeviceInformationSyncClockSkewTooBig(:final server) => server,
    DeviceInformationSyncNetworkError(:final server) => server,
    DeviceInformationSyncOperationNotSupportedByBackend(:final server) =>
      server,
    OperationClockSkewTooBig(:final server) => server,
    OperationNetworkError(:final server) => server,
    OutOfBandOperationNetworkError(:final server) => server,
    PendingOutOfBandOperationsClockSkewTooBig(:final server) => server,
    PendingOutOfBandOperationsNetworkError(:final server) => server,
    PendingOutOfBandOperationsOperationNotSupportedByBackend(:final server) =>
      server,
    _ => null,
  };

  HttpError? get httpError => switch (this) {
    AuthCloudApiClockSkewTooBig(:final httpError) => httpError,
    AuthCloudApiNetworkError(:final httpError) => httpError,
    AuthenticationNetworkError(:final httpError) => httpError,
    DeviceInformationChangeClockSkewTooBig(:final httpError) => httpError,
    DeviceInformationChangeNameAlreadyExists(:final httpError) => httpError,
    DeviceInformationChangeNetworkError(:final httpError) => httpError,
    DeviceInformationChangeNotFound(:final httpError) => httpError,
    DeviceInformationCheckClockSkewTooBig(:final httpError) => httpError,
    DeviceInformationCheckForbidden(:final httpError) => httpError,
    DeviceInformationCheckNetworkError(:final httpError) => httpError,
    DeviceInformationSyncClockSkewTooBig(:final httpError) => httpError,
    DeviceInformationSyncNetworkError(:final httpError) => httpError,
    OperationClockSkewTooBig(:final httpError) => httpError,
    OperationNetworkError(:final httpError) => httpError,
    OutOfBandOperationNetworkError(:final httpError) => httpError,
    PendingOutOfBandOperationsClockSkewTooBig(:final httpError) => httpError,
    PendingOutOfBandOperationsNetworkError(:final httpError) => httpError,
    _ => null,
  };

  FidoErrorCode? get errorCode => switch (this) {
    OperationFidoError(:final errorCode) => errorCode,
    AuthCloudApiFidoError(:final errorCode) => errorCode,
    AuthenticationFidoError(:final errorCode) => errorCode,
    _ => null,
  };
}
