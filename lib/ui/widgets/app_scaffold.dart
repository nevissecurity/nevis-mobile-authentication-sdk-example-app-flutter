// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_route.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldContent(
      body: body,
    );
  }
}

class AppScaffoldContent extends StatelessWidget {
  final Widget body;

  const AppScaffoldContent({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final bloc = context.read<AppBloc>();
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (oldState, newState) =>
          _isCurrent(context) && newState.isListenable,
      buildWhen: (oldState, newState) =>
          _isCurrent(context) && !newState.isListenable,
      listener: (ctx, state) async {
        if (state is VerifyFingerPrintState) {
          bloc.add(UserFingerPrintEvent());
        } else if (state is VerifyBiometricState) {
          bloc.add(UserBiometricEvent(
            title: localization.biometricPopUpTitle,
            description: localization.biometricPopUpDescription,
            cancelButtonText: localization.popUpNegativeButtonText,
          ));
        } else if (state is VerifyDevicePasscodeState) {
          bloc.add(UserDevicePasscodeEvent(
            title: localization.devicePasscodePopUpTitle,
            description: localization.devicePasscodePopUpDescription,
          ));
        } else if (state is VerifyPinState &&
            currentScreen(context) != PinRoute.pin) {
          bloc.add(UserPinEvent(
            protectionStatus: state.protectionStatus,
            lastRecoverableError: state.lastRecoverableError,
          ));
        }
      },
      builder: (ctx, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: body,
            ),
          ),
        );
      },
    );
  }

  bool _isCurrent(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent ?? false;
  }

  String? currentScreen(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }
}
