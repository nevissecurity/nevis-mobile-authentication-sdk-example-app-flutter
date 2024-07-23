// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/pin/pin_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/model/pin_credentials.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/navigation/pin_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/pin/pin_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!;
    final parameter = modalRoute.settings.arguments as PinParameter;

    return BlocProvider<PinBloc>(
      create: (ctx) => GetIt.I.get<PinBloc>()
        ..add(PinCreatedEvent(
          mode: parameter.mode,
          username: parameter.username,
          pinVerificationData: parameter.pinVerificationData,
        )),
      child: const PinScreenContent(),
    );
  }
}

class PinScreenContent extends StatefulWidget {
  const PinScreenContent({super.key});

  @override
  State<PinScreenContent> createState() => _PinScreenContentState();
}

class _PinScreenContentState extends State<PinScreenContent> {
  final pinController = TextEditingController();
  final oldPinController = TextEditingController();
  late AppLocalizations _localization;

  @override
  void dispose() {
    pinController.dispose();
    oldPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context)!;
    return BlocBuilder<PinBloc, PinState>(
      builder: (_, state) {
        if (state is PinUpdatedState &&
            state.previousMode != null &&
            state.mode != state.previousMode) {
          pinController.clear();
          oldPinController.clear();
        }

        final errorMessage = _extractErrorMessage(state);
        return (state is PinUpdatedState)
            ? AppScaffold(
                body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleLabel(state.mode),
                        AppText(text: _description(state.mode)),
                        if (state.mode == PinMode.credentialChange)
                          _oldPinField(),
                        _pinField(state.mode),
                        if (errorMessage != null)
                          _errorMessageWidget(errorMessage),
                        if (state.protectionStatus
                            is! PinProtectionStatusLockedOut)
                          _infoMessageWidget(state),
                        _confirmButton(state.mode),
                        const SizedBox(height: 16),
                        _cancelButton(state.mode),
                      ],
                    )),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  String _title(PinMode mode) {
    switch (mode) {
      case PinMode.enrollment:
        return _localization.pinScreenTitleEnrollment;
      case PinMode.verification:
        return _localization.pinScreenTitleVerification;
      case PinMode.credentialChange:
        return _localization.pinScreenTitleCredentialChange;
    }
  }

  Widget _titleLabel(PinMode mode) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: AppText.title(_title(mode)),
      ),
    );
  }

  String _description(PinMode mode) {
    switch (mode) {
      case PinMode.enrollment:
        return _localization.pinScreenDescriptionEnrollment;
      case PinMode.verification:
        return _localization.pinScreenDescriptionVerification;
      case PinMode.credentialChange:
        return _localization.pinScreenDescriptionCredentialChange;
    }
  }

  Widget _oldPinField() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          obscureText: true,
          controller: oldPinController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: _localization.pinOldPinTitle,
            hintText: _localization.pinOldPinPlaceholder,
          ),
        ),
      ],
    );
  }

  Widget _pinField(PinMode mode) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          obscureText: true,
          controller: pinController,
          keyboardType: TextInputType.number,
          textInputAction: (mode == PinMode.verification)
              ? TextInputAction.done
              : TextInputAction.next,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: (mode == PinMode.credentialChange)
                ? _localization.pinNewPinTitle
                : _localization.pinPinTitle,
            hintText: (mode == PinMode.credentialChange)
                ? _localization.pinNewPinPlaceholder
                : _localization.pinPinPlaceholder,
          ),
        ),
      ],
    );
  }

  Widget _errorMessageWidget(String errorMessage) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  Widget _infoMessageWidget(PinUpdatedState state) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          _infoMessageText(state),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  String _infoMessageText(PinUpdatedState state) {
    if (state.protectionStatus is PinProtectionStatusLockedOut) {
      return _localization.pinProtectionStatusDescriptionLocked;
    } else if (state.protectionStatus is PinProtectionStatusLastAttemptFailed) {
      final status =
          state.protectionStatus as PinProtectionStatusLastAttemptFailed;
      final remainingRetries = status.remainingRetries;
      final coolDownTime = status.coolDownTime.inSeconds;
      // NOTE: if coolDownTime is not zero, a countdown timer should be started.
      return _localization.pinProtectionStatusDescriptionUnlocked(
          remainingRetries, coolDownTime);
    }
    return "";
  }

  Widget _confirmButton(PinMode mode) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Button.outlined(
          text: _localization.confirmButtonTitle,
          onPressed: () {
            _confirmPin(mode);
          },
        ),
      ],
    );
  }

  Widget _cancelButton(PinMode mode) {
    return Button.outlined(
      text: _localization.cancelButtonTitle,
      onPressed: () {
        context.read<PinBloc>().add(UserCancelledEvent(mode));
      },
    );
  }

  void _confirmPin(PinMode mode) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<PinBloc>().add(PinEnterEvent(
          mode: mode,
          credentials: _makeCredentials(mode),
        ));
  }

  PinCredentials _makeCredentials(PinMode mode) {
    switch (mode) {
      case PinMode.enrollment:
        return PinCredentials(
          pinValue: pinController.text,
        );
      case PinMode.verification:
        return PinCredentials(pinValue: pinController.text);
      case PinMode.credentialChange:
        return PinCredentials(
          oldValue: oldPinController.text,
          pinValue: pinController.text,
        );
    }
  }

  String? _extractErrorMessage(PinState state) {
    if (state is PinUpdatedState) {
      var text = state.lastRecoverableError?.description;
      if (state.lastRecoverableError?.cause != null) {
        text = "$text ${state.lastRecoverableError?.cause}";
      }
      return text;
    }
    return null;
  }
}
