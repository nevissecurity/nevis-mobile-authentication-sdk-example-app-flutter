// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_kind.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/credential/credential_mode.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/credential_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/model/credentials.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/navigation/credential_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/widgets/credential_description_label.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/widgets/credential_error_label.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/widgets/credential_field.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/widgets/credential_info_label.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/widgets/credential_old_field.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/credential/widgets/credential_title_label.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';

class CredentialScreen extends StatelessWidget {
  const CredentialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!;
    final parameter = modalRoute.settings.arguments as CredentialParameter;

    return BlocProvider<CredentialBloc>(
      create: (ctx) => GetIt.I.get<CredentialBloc>()
        ..add(CredentialCreatedEvent(
          mode: parameter.mode,
          kind: parameter.kind,
          username: parameter.username,
          verificationData: parameter.verificationData,
        )),
      child: const CredentialScreenContent(),
    );
  }
}

class CredentialScreenContent extends StatefulWidget {
  const CredentialScreenContent({super.key});

  @override
  State<CredentialScreenContent> createState() =>
      _CredentialScreenContentState();
}

class _CredentialScreenContentState extends State<CredentialScreenContent> {
  final credentialController = TextEditingController();
  final oldCredentialController = TextEditingController();
  late AppLocalizations _localization;

  @override
  void dispose() {
    credentialController.dispose();
    oldCredentialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context)!;
    return BlocBuilder<CredentialBloc, CredentialState>(
      builder: (_, state) {
        if (state is CredentialUpdatedState &&
            state.previousMode != null &&
            state.mode != state.previousMode) {
          credentialController.clear();
          oldCredentialController.clear();
        }

        final errorMessage = _extractErrorMessage(state);
        return (state is CredentialUpdatedState)
            ? AppScaffold(
                body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CredentialTitleLabel(
                          mode: state.mode,
                          kind: state.kind,
                        ),
                        CredentialDescriptionLabel(
                          mode: state.mode,
                          kind: state.kind,
                        ),
                        if (state.mode == CredentialMode.change)
                          CredentialOldField(
                            textEditingController: oldCredentialController,
                            kind: state.kind,
                          ),
                        CredentialField(
                          textEditingController: credentialController,
                          mode: state.mode,
                          kind: state.kind,
                        ),
                        if (errorMessage != null)
                          CredentialErrorLabel(errorMessage: errorMessage),
                        if (state.pinProtectionStatus
                                is! PinProtectionStatusUnlocked ||
                            state.passwordProtectionStatus
                                is! PasswordProtectionStatusUnlocked)
                          CredentialInfoLabel(
                            pinProtectionStatus: state.pinProtectionStatus,
                            passwordProtectionStatus:
                                state.passwordProtectionStatus,
                          ),
                        _confirmButton(state.mode, state.kind),
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

  Widget _confirmButton(CredentialMode mode, CredentialKind kind) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Button.outlined(
          text: _localization.confirmButtonTitle,
          onPressed: () {
            context.read<CredentialBloc>().add(
                  CredentialEnterEvent(
                    mode: mode,
                    kind: kind,
                    credentials: _makeCredentials(mode),
                  ),
                );
          },
        ),
      ],
    );
  }

  Widget _cancelButton(CredentialMode mode) {
    return Button.outlined(
      text: _localization.cancelButtonTitle,
      onPressed: () {
        context.read<CredentialBloc>().add(UserCancelledEvent(mode));
      },
    );
  }

  Credentials _makeCredentials(CredentialMode mode) {
    switch (mode) {
      case CredentialMode.enrollment:
        return Credentials(value: credentialController.text);
      case CredentialMode.verification:
        return Credentials(value: credentialController.text);
      case CredentialMode.change:
        return Credentials(
          oldValue: oldCredentialController.text,
          value: credentialController.text,
        );
    }
  }

  String? _extractErrorMessage(CredentialState state) {
    if (state is! CredentialUpdatedState) {
      return null;
    }

    if (state.lastRecoverableError == null) {
      return null;
    }

    var message = state.lastRecoverableError?.description;
    final cause = state.lastRecoverableError?.cause;
    if (cause != null) {
      message = '$message $cause';
    }
    return message;
  }
}
