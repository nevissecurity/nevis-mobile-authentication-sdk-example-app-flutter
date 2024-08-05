// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/domain_state/domain_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/pin_change_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';

@Injectable(as: PinChanger)
class PinChangerImpl extends PinChanger {
  final DomainBloc _domainBloc;
  final StateRepository<PinChangeState> _stateRepository;

  PinChangerImpl(
    this._domainBloc,
    this._stateRepository,
  );

  @override
  void changePin(PinChangeContext context, PinChangeHandler handler) {
    debugPrint(context.lastRecoverableError != null
        ? 'PIN change failed. Please try again. Error: ${context.lastRecoverableError?.description}'
        : 'Please start PIN change.');

    _stateRepository.save(PinChangeState(context, handler));
    final event = CredentialChangeEvent(
      aaid: Aaid.pin.rawValue,
      pinProtectionStatus: context.authenticatorProtectionStatus,
      lastRecoverableError: context.lastRecoverableError,
    );
    _domainBloc.add(event);
  }

//  You can add custom PIN policy by overriding the `pinPolicy` getter
//  The default minimum and maximum PIN length is 6 without any validation during PIN enrollment or change.
//
//  @override
//  PinPolicy get pinPolicy => CustomPinPolicyImpl(maxLength: 8, minLength: 4);
}
