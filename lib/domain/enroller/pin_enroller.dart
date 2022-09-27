// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_enrollment_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@Injectable(as: PinEnroller)
class PinEnrollerImpl extends PinEnroller {
  final DomainBloc _domainBloc;
  final StateRepository<EnrollPinState> _stateRepository;

  PinEnrollerImpl(this._stateRepository, this._domainBloc);

  @override
  void enrollPin(PinEnrollmentContext context, PinEnrollmentHandler handler) {
    if (context.lastRecoverableError != null) {
      debugPrint(
          'There was a recoverable error: ${context.lastRecoverableError.runtimeType} ${context.lastRecoverableError?.description}');
    }
    _stateRepository.save(EnrollPinState(context, handler));
    final event = PinEnrollmentEvent(
      lastRecoverableError: context.lastRecoverableError,
      protectionStatus: null,
    );
    _domainBloc.add(event);
  }

  @override
  void onValidCredentialsProvided() {
    debugPrint('onValidCredentialsProvided');
  }

//  You can add custom PIN policy by overriding the `pinPolicy` getter
//  The default is `PinPolicy(minLength: 6, maxLength: 6)`
//  @override
//  PinPolicy get pinPolicy => PinPolicy(minLength: 5, maxLength: 8);
}
