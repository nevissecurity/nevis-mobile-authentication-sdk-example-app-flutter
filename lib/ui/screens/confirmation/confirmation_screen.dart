// Copyright © 2024 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/navigation/confirmation_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/confirmation_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/confirmation_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/confirmation/confirmation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/localization_utils.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!;
    final parameter = modalRoute.settings.arguments as ConfirmationParameter;
    return BlocProvider<ConfirmationBloc>(
      create: (ctx) => GetIt.I.get<ConfirmationBloc>()
        ..add(ConfirmationCreatedEvent(parameter)),
      child: const ConfirmationContent(),
    );
  }
}

class ConfirmationContent extends StatefulWidget {
  const ConfirmationContent({super.key});

  @override
  State<ConfirmationContent> createState() => _ConfirmationContentState();
}

class _ConfirmationContentState extends State<ConfirmationContent>
    with WidgetsBindingObserver {
  late AppLocalizations _localization;
  late ConfirmationBloc _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      debugPrint(
          "[ConfirmationScreen didChangeAppLifecycleState] State resumed.");
      _bloc.add(ConfirmationResumeListeningEvent());
    } else if (state == AppLifecycleState.paused) {
      debugPrint(
          "[ConfirmationScreen didChangeAppLifecycleState] State paused.");
      _bloc.add(ConfirmationPauseListeningEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context)!;
    _bloc = context.read<ConfirmationBloc>();

    return BlocConsumer<ConfirmationBloc, ConfirmationState>(
      listenWhen: (oldState, newState) => newState.isListenable,
      buildWhen: (oldState, newState) => !newState.isListenable,
      listener: (ctx, state) async {
        if (state is ConfirmBiometricState) {
          _bloc.add(ConfirmationBiometricEvent(
            title: _localization.biometricPopUpTitle,
            description: _localization.biometricPopUpDescription,
            cancelButtonText: _localization.cancelButtonTitle,
          ));
        } else if (state is ConfirmDevicePasscodeState) {
          _bloc.add(ConfirmationDevicePasscodeEvent(
            title: _localization.devicePasscodePopUpTitle,
            description: _localization.devicePasscodePopUpDescription,
          ));
        }
      },
      builder: (ctx, state) {
        return AppScaffold(
          body: (state is ConfirmationLoadedState)
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _descriptionWidget(state),
                      _confirmButton(),
                      const SizedBox(height: 16.0),
                      _cancelButton(),
                      const SizedBox(height: 16.0),
                    ],
                  ))
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget _descriptionWidget(ConfirmationLoadedState state) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText.title(
              _localization.confirmationScreenDescription(
                state.aaid.resolve(_localization),
              ),
            ),
            if (state is ConfirmFingerPrintLoadedState)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppText.body(
                  _localization
                      .confirmationScreenDescriptionFingerprintVerification,
                ),
              ),
          ]),
    );
  }

  Widget _confirmButton() {
    return Column(
      children: [
        Button.outlined(
          text: _localization.confirmButtonTitle,
          onPressed: () {
            _bloc.add(ConfirmationUserAcceptedEvent());
          },
        ),
      ],
    );
  }

  Widget _cancelButton() {
    return Column(
      children: [
        Button.outlined(
          text: _localization.cancelButtonTitle,
          onPressed: () {
            _bloc.add(ConfirmationUserCancelledEvent());
          },
        ),
      ],
    );
  }
}
