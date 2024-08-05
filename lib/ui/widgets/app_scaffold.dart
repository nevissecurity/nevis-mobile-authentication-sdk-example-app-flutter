// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/app_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/navigation/credential_route.dart';

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

  const AppScaffoldContent({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppBloc>();
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (oldState, newState) =>
          _isCurrent(context) && newState.isListenable,
      buildWhen: (oldState, newState) =>
          _isCurrent(context) && !newState.isListenable,
      listener: (ctx, state) async {
        if (state is VerifyCredentialState &&
            currentScreen(context) != CredentialRoute.credential) {
          bloc.add(VerifyUserCredentialEvent(
            kind: state.kind,
            pinProtectionStatus: state.pinProtectionStatus,
            passwordProtectionStatus: state.passwordProtectionStatus,
            lastRecoverableError: state.lastRecoverableError,
          ));
        }
      },
      builder: (ctx, state) {
        return PopScope(
          canPop: false,
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
