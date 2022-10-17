// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/home/home_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/scrollable_column.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final homeBloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) {
        return AppScaffold(
          body: state is! HomeLoadedState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScrollableColumn(
                    flex: true,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppText.title(localization.appTitle),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 0.0, left: 0.0, bottom: 64.0),
                          child: Text(
                            localization.homeRegisteredAccounts(state.registeredAccounts),
                          ),
                        ),
                      ),
                      Button.outlined(
                          text: localization.readQrCode,
                          onPressed: () {
                            homeBloc.add(ReadQrCodeEvent());
                          }),
                      Button.outlined(
                          text: localization.inBandAuthenticate,
                          onPressed: () {
                            homeBloc.add(InBandAuthenticationEvent());
                          }),
                      Button.outlined(
                        text: localization.deregister,
                        onPressed: () {
                          homeBloc.add(DeregisterEvent());
                        },
                      ),
                      Button.outlined(
                          text: localization.pinChange,
                          onPressed: () {
                            homeBloc.add(PinChangeEvent());
                          }),
                      Button.outlined(
                          text: localization.changeDeviceInformation,
                          onPressed: () {
                            homeBloc.add(ChangeDeviceInformationEvent());
                          }),
                      Button.outlined(
                          text: localization.authCloudApiRegistration,
                          onPressed: () {
                            homeBloc.add(AuthCloudApiRegistrationEvent());
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(localization.homeSoftwareDeliveredOnly),
                      ),
                      Button.outlined(
                          text: localization.inBandRegister,
                          onPressed: () {
                            homeBloc.add(InBandRegisterEvent());
                          }),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
