// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/navigation/transaction_confirmation_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/transaction_confirmation/transaction_confirmation_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/scrollable_column.dart';

class TransactionConfirmationScreen extends StatelessWidget {
  const TransactionConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionConfirmationBloc>(
      create: (_) {
        final params = ModalRoute.of(context)!.settings.arguments
            as TransactionConfirmationParameter;
        return GetIt.I.get<TransactionConfirmationBloc>()
          ..add(TransactionConfirmationScreenCreatedEvent(params));
      },
      child: const TransactionConfirmationContent(),
    );
  }
}

class TransactionConfirmationContent extends StatelessWidget {
  const TransactionConfirmationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionConfirmationBloc,
        TransactionConfirmationState>(
      builder: (_, state) {
        final localization = AppLocalizations.of(context)!;
        final bloc = context.read<TransactionConfirmationBloc>();
        return AppScaffold(
          body: Center(
            child: ScrollableColumn(
              flex: true,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText.title(
                      localization.transactionConfirmationScreenTitle),
                ),
                Expanded(child: _data(state)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Button.outlined(
                        text: localization.confirmButtonTitle,
                        onPressed: () {
                          bloc.add(TransactionConfirmationUserAcceptedEvent());
                        },
                      ),
                      Button.outlined(
                        text: localization.cancelButtonTitle,
                        onPressed: () {
                          bloc.add(TransactionConfirmationUserCancelledEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _data(TransactionConfirmationState state) {
    if (state is TransactionConfirmationInitialState) {
      return Text(state.transactionData);
    } else {
      return const CircularProgressIndicator();
    }
  }
}
