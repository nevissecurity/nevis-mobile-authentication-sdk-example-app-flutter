// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/error/error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/device_information_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/change_device_information_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_state.dart';

@injectable
class ChangeDeviceInformationBloc
    extends Bloc<ChangeDeviceInformationEvent, ChangeDeviceInformationState> {
  final GlobalNavigationManager _globalNavigationManager;
  final ChangeDeviceInformationUseCase _changeDeviceInformationUseCase;
  final DeviceInformationUseCase _deviceInformationUseCase;
  final ErrorHandler _errorHandler;

  DeviceInformation? _deviceInformation;

  ChangeDeviceInformationBloc(
    this._globalNavigationManager,
    this._changeDeviceInformationUseCase,
    this._deviceInformationUseCase,
    this._errorHandler,
  ) : super(ChangeDeviceInformationInitial()) {
    on<ChangeDeviceInformationCreatedEvent>(_handleCreated);
    on<ChangeConfirmedEvent>(_handleConfirm);
    on<ChangeCancelledEvent>(_handleCancel);
  }

  void _handleCreated(
    ChangeDeviceInformationCreatedEvent event,
    Emitter<ChangeDeviceInformationState> emit,
  ) async {
    _deviceInformation = await _deviceInformationUseCase.execute();
    if (_deviceInformation == null) {
      _errorHandler.handle(BusinessException.deviceInformationNotFound());
    }
    emit(ChangeDeviceInformationLoaded(_deviceInformation?.name));
  }

  void _handleConfirm(
    ChangeConfirmedEvent event,
    Emitter<ChangeDeviceInformationState> emit,
  ) async {
    await _changeDeviceInformationUseCase
        .execute(
      name: event.newName,
      fcmRegistrationToken: _deviceInformation?.fcmRegistrationToken,
    )
        .catchError((e) {
      _errorHandler.handle(e);
    });
  }

  void _handleCancel(
    ChangeCancelledEvent event,
    Emitter<ChangeDeviceInformationState> emit,
  ) {
    _globalNavigationManager.popUntilHome();
  }
}
