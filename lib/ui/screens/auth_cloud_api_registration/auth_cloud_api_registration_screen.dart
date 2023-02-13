// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/auth_cloud_api_registration_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/auth_cloud_api_registration/model/auth_cloud_api_registration_validation_error.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';

class AuthCloudApiRegistrationScreen extends StatelessWidget {
  const AuthCloudApiRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCloudApiRegistrationBloc>(
      create: (ctx) => GetIt.I.get<AuthCloudApiRegistrationBloc>(),
      child: const AuthCloudApiRegistrationContent(),
    );
  }
}

class AuthCloudApiRegistrationContent extends StatefulWidget {
  const AuthCloudApiRegistrationContent({Key? key}) : super(key: key);

  @override
  State<AuthCloudApiRegistrationContent> createState() =>
      _AuthCloudApiRegistrationContentState();
}

class _AuthCloudApiRegistrationContentState
    extends State<AuthCloudApiRegistrationContent> {
  final _enrollResponseController = TextEditingController();
  final _appLinkUriController = TextEditingController();
  String? _errorMessage;
  late AppLocalizations _localization;

  @override
  void dispose() {
    _enrollResponseController.dispose();
    _appLinkUriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context)!;
    return BlocBuilder<AuthCloudApiRegistrationBloc,
        AuthCloudApiRegistrationState>(
      builder: (ctx, state) {
        return AppScaffold(
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(_localization.authCloudApiRegistrationTitle),
                  _enrollResponseField(),
                  _appLinkUriField(),
                  if (_errorMessage != null) _errorMessageWidget(),
                  _confirmButton(),
                  const SizedBox(height: 16),
                  _cancelButton(),
                ],
              )),
        );
      },
    );
  }

  Widget _enrollResponseField() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: _enrollResponseController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (_) {
            // we just want the widget to rebuild, so the button can get into a correct state
            setState(() {});
          },
          onEditingComplete: () =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: _localization.authCloudApiRegistrationEnrollResponse,
            hintText: _localization.authCloudApiRegistrationEnrollResponse,
          ),
        ),
      ],
    );
  }

  Widget _appLinkUriField() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: _appLinkUriController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (_) {
            // we just want the widget to rebuild, so the button can get into a correct state
            setState(() {});
          },
          onEditingComplete: () =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: _localization.authCloudApiRegistrationAppLinkUri,
            hintText: _localization.authCloudApiRegistrationAppLinkUri,
          ),
        ),
      ],
    );
  }

  Widget _errorMessageWidget() {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  Widget _confirmButton() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Button.outlined(
          text: _localization.confirmButtonTitle,
          onPressed: () {
            _confirmRegistration();
          },
        ),
      ],
    );
  }

  Widget _cancelButton() {
    return Button.outlined(
      text: _localization.cancelButtonTitle,
      onPressed: () {
        context
            .read<AuthCloudApiRegistrationBloc>()
            .add(RegistrationCancelledEvent());
      },
    );
  }

  void _confirmRegistration() {
    FocusManager.instance.primaryFocus?.unfocus();
    switch (_validateData()) {
      case AuthCloudApiRegistrationValidationError.none:
        setState(() {
          _errorMessage = null;
        });

        final event = RegistrationConfirmedEvent(
          enrollResponse: _enrollResponseController.text,
          appLinkUri: _appLinkUriController.text,
        );
        context.read<AuthCloudApiRegistrationBloc>().add(event);
        break;
      case AuthCloudApiRegistrationValidationError.missingData:
        setState(() {
          _errorMessage =
              _localization.authCloudApiRegistrationErrorMissingData;
        });
        break;
      case AuthCloudApiRegistrationValidationError.wrongData:
        setState(() {
          _errorMessage = _localization.authCloudApiRegistrationErrorWrongData;
        });
        break;
    }
  }

  AuthCloudApiRegistrationValidationError _validateData() {
    if (_enrollResponseController.text.isEmpty &&
        _appLinkUriController.text.isEmpty) {
      return AuthCloudApiRegistrationValidationError.missingData;
    }

    if (_enrollResponseController.text.isNotEmpty &&
        _appLinkUriController.text.isNotEmpty) {
      return AuthCloudApiRegistrationValidationError.wrongData;
    }

    return AuthCloudApiRegistrationValidationError.none;
  }
}
