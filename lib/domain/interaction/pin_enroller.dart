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
    debugPrint(context.lastRecoverableError != null
        ? 'PIN enrollment failed. Please try again. Error: ${context.lastRecoverableError?.description}'
        : 'Please start PIN enrollment.');

    _stateRepository.save(EnrollPinState(context, handler));
    final event = PinEnrollmentEvent(
      lastRecoverableError: context.lastRecoverableError,
      protectionStatus: null,
    );
    _domainBloc.add(event);
  }

  @override
  void onValidCredentialsProvided() {
    debugPrint('Valid PIN credentials provided.');
  }

//  You can add custom PIN policy by overriding the `pinPolicy` getter
//  The default minimum and maximum PIN length is 6 without any validation during PIN enrollment or change.
//
//  @override
//  PinPolicy get pinPolicy => CustomPinPolicyImpl(maxLength: 8, minLength: 4);
}
