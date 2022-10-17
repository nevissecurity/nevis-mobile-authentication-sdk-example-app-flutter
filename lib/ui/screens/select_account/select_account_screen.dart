// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/navigation/select_account_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/select_account/select_account_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';

class SelectAccountScreen extends StatelessWidget {
  const SelectAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!;
    final parameter = modalRoute.settings.arguments as SelectAccountParameter;
    return BlocProvider<SelectAccountBloc>(
      create: (ctx) => GetIt.I.get<SelectAccountBloc>()..add(SelectAccountCreatedEvent(parameter)),
      child: const SelectAccountContent(),
    );
  }
}

class SelectAccountContent extends StatelessWidget {
  const SelectAccountContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocBuilder<SelectAccountBloc, SelectAccountState>(
      builder: (_, state) {
        return AppScaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText.title(localization.selectAccountScreenTitle),
                ),
                if (state is SelectAccountInitialState)
                  ..._list(context: context, localizations: localization, state: state)
                else
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _list({
    required BuildContext context,
    required AppLocalizations localizations,
    required SelectAccountInitialState state,
  }) {
    final bloc = context.read<SelectAccountBloc>();
    return [
      Expanded(
        child: ListView.builder(
            itemCount: state.accounts.length,
            itemBuilder: (BuildContext context, int index) {
              final account = state.accounts.elementAt(index);
              return ListTile(
                title: Text(account.username),
                onTap: () {
                  bloc.add(AccountSelectedEvent(account));
                },
              );
            }),
      )
    ];
  }
}
