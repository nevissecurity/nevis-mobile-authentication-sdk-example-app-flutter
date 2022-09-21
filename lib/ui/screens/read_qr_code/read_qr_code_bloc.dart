// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/error/error_handler.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/usecase/oob_process_usecase.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/read_qr_code/read_qr_code_state.dart';

@injectable
class ReadQrCodeBloc extends Bloc<ReadQrCodeEvent, ReadQrCodeState> {
  final OobProcessUseCase _oobProcessUseCase;
  final ErrorHandler _errorHandler;

  ReadQrCodeBloc(
    this._oobProcessUseCase,
    this._errorHandler,
  ) : super(ReadQrCodeInitialState()) {
    on<QrCodeScannedEvent>(_handleQrCodeScannedEvent);
  }

  Future<void> _handleQrCodeScannedEvent(QrCodeScannedEvent event, Emitter<ReadQrCodeState> emit) async {
    await _oobProcessUseCase.execute(event.content).catchError((error) {
      _errorHandler.handle(error);
    });
  }
}
