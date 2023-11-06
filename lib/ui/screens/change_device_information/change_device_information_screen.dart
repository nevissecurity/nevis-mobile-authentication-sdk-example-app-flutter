// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/change_device_information/change_device_information_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';

class ChangeDeviceInformationScreen extends StatefulWidget {
  const ChangeDeviceInformationScreen({super.key});

  @override
  State<ChangeDeviceInformationScreen> createState() =>
      _ChangeDeviceInformationScreenState();
}

class _ChangeDeviceInformationScreenState
    extends State<ChangeDeviceInformationScreen> {
  final _nameController = TextEditingController();
  late AppLocalizations _localization;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context)!;
    return BlocBuilder<ChangeDeviceInformationBloc,
        ChangeDeviceInformationState>(
      builder: (ctx, state) {
        return AppScaffold(
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(_localization.changeDeviceInformationTitle),
                  _nameLabel(state),
                  _nameField(),
                  _confirmButton(),
                  const SizedBox(height: 16),
                  _cancelButton(),
                ],
              )),
        );
      },
    );
  }

  Widget _nameLabel(ChangeDeviceInformationState state) {
    String text;
    if (state is ChangeDeviceInformationLoaded &&
        state.deviceInformationCurrentName != null) {
      text = _localization.changeDeviceInformationCurrentName(
          state.deviceInformationCurrentName!);
    } else {
      text = _localization.changeDeviceInformationEmptyCurrentName;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text),
    );
  }

  Widget _nameField() {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (_) {
            // we just want the widget to rebuild, so the button can get into a correct state
            setState(() {});
          },
          onEditingComplete: () =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: _localization.changeDeviceInformationNewName,
            hintText: _localization.changeDeviceInformationNewName,
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
          text: _localization.confirmButtonTitle,
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context
                .read<ChangeDeviceInformationBloc>()
                .add(ChangeConfirmedEvent(_nameController.text));
          },
        ),
      ],
    );
  }

  Widget _cancelButton() {
    return Button.outlined(
      text: _localization.cancelButtonTitle,
      onPressed: () {
        context.read<ChangeDeviceInformationBloc>().add(ChangeCancelledEvent());
      },
    );
  }
}
