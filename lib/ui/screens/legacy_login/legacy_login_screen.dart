// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/legacy_login/legacy_login_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';

class LegacyLoginScreen extends StatelessWidget {
  const LegacyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LegacyLoginBloc>(
      create: (ctx) => GetIt.I.get<LegacyLoginBloc>(),
      child: const LegacyLoginContent(),
    );
  }
}

class LegacyLoginContent extends StatefulWidget {
  const LegacyLoginContent({super.key});

  @override
  State<LegacyLoginContent> createState() => _LegacyLoginContentState();
}

class _LegacyLoginContentState extends State<LegacyLoginContent> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late AppLocalizations _localization;
  late GlobalNavigationManager _globalNavigationManager;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context)!;
    _globalNavigationManager = GetIt.I.get<GlobalNavigationManager>();

    return BlocConsumer<LegacyLoginBloc, LegacyLoginState>(
      listener: (_, state) {},
      builder: (ctx, state) {
        return AppScaffold(
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText.title(_localization.registrationScreenTitle),
                  ),
                  _usernameField(),
                  _passwordField(),
                  _confirmButton(),
                  _cancelButton(),
                ],
              )),
        );
      },
    );
  }

  Widget _usernameField() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: usernameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: _localization.registrationUsernameTitle,
            hintText: _localization.registrationUsernamePlaceholder,
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: _localization.registrationPasswordTitle,
            hintText: _localization.registrationPasswordPlaceholder,
          ),
        ),
      ],
    );
  }

  Widget _confirmButton() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Button.outlined(
          text: _localization.registrationConfirmButtonTitle,
          onPressed: () {
            final event = ConfirmEvent(
              username: usernameController.text,
              password: passwordController.text,
            );
            context.read<LegacyLoginBloc>().add(event);
          },
        ),
      ],
    );
  }

  Widget _cancelButton() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Button.outlined(
          text: _localization.registrationCancelButtonTitle,
          onPressed: () {
            _globalNavigationManager.popUntilHome();
          },
        ),
      ],
    );
  }
}
