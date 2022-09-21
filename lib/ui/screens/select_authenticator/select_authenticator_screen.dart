// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/navigation/select_authenticator_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_authenticator/select_authenticator_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/authenticator_list_tile.dart';

class SelectAuthenticatorScreen extends StatelessWidget {
  const SelectAuthenticatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)!.settings.arguments as SelectAuthenticatorParameter;
    return BlocProvider<SelectAuthenticatorBloc>(
      create: (_) {
        return GetIt.I.get<SelectAuthenticatorBloc>()..add(SelectAuthenticatorCreatedEvent(params));
      },
      child: const SelectAuthenticatorContent(),
    );
  }
}

class SelectAuthenticatorContent extends StatelessWidget {
  const SelectAuthenticatorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _localization = AppLocalizations.of(context)!;

    return BlocConsumer<SelectAuthenticatorBloc, SelectAuthenticatorState>(
      listener: (_, state) {},
      builder: (ctx, state) {
        return AppScaffold(
          body: Center(
              child: (state is SelectAuthenticatorLoadedState)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText.title(_localization.selectAuthenticatorScreenTitle),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: state.parameter.authenticators.length,
                              itemBuilder: (BuildContext context, int index) {
                                final authenticator = state.parameter.authenticators.elementAt(index);
                                return AuthenticatorListTile(
                                  authenticator: authenticator,
                                  onTap: () {
                                    context
                                        .read<SelectAuthenticatorBloc>()
                                        .add(AuthenticatorSelectedEvent(authenticator));
                                  },
                                );
                              }),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator()),
        );
      },
    );
  }
}
