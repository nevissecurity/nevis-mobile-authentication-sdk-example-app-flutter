// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/client_provider/client_provider.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

abstract class ChangeDeviceInformationUseCase {
  Future<void> execute({
    String? name,
    String? fcmRegistrationToken,
    bool? disablePushNotifications,
  });
}

@Injectable(as: ChangeDeviceInformationUseCase)
class ChangeDeviceInformationUseCaseImpl
    implements ChangeDeviceInformationUseCase {
  final ClientProvider _clientProvider;
  final StateRepository<OperationType> _operationTypeRepository;
  final DomainBloc _domainBloc;
  final ErrorHandler _errorHandler;

  ChangeDeviceInformationUseCaseImpl(
    this._clientProvider,
    this._operationTypeRepository,
    this._domainBloc,
    this._errorHandler,
  );

  @override
  Future<void> execute({
    String? name,
    String? fcmRegistrationToken,
    bool? disablePushNotifications,
  }) async {
    _operationTypeRepository.save(OperationType.deviceInformationChange);
    var deviceInformationChange =
        _clientProvider.client.operations.deviceInformationChange //
            .onSuccess(() {
      debugPrint('Change device information succeeded.');
      _domainBloc.add(ResultEvent());
      _operationTypeRepository.reset();
    }).onError((error) {
      debugPrint('Change device information failed: ${error.runtimeType}');
      _errorHandler.handle(error);
    });

    if (name != null) {
      deviceInformationChange.name(name);
    }

    if (fcmRegistrationToken != null) {
      deviceInformationChange.fcmRegistrationToken(fcmRegistrationToken);
    }

    if (disablePushNotifications != null && disablePushNotifications) {
      deviceInformationChange.disablePushNotifications();
    }

    return await deviceInformationChange.execute();
  }
}
