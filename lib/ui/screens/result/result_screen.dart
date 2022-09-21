// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/operation_result_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/navigation/result_parameter.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_state.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_scaffold.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/app_text.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/widgets/button.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/util/localization_utils.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!;
    final parameter = modalRoute.settings.arguments as ResultParameter;
    return BlocProvider<ResultBloc>(
      create: (ctx) => GetIt.I.get<ResultBloc>()..add(ResultCreatedEvent(parameter)),
      child: const ResultContent(),
    );
  }
}

class ResultContent extends StatelessWidget {
  const ResultContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _localization = AppLocalizations.of(context)!;

    return BlocConsumer<ResultBloc, ResultState>(
      listener: (_, state) {},
      builder: (ctx, state) {
        return AppScaffold(
          body: (state is ResultLoadedState)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText.title(_title(_localization, state)),
                              if (state.errorType != null) AppText.body(state.errorType!.resolve(_localization)),
                              if (state.description != null) AppText.body(state.description!),
                            ]),
                      ),
                      Button.outlined(
                        text: _localization.confirmButtonTitle,
                        onPressed: () {
                          final event = NavigateToHomeEvent(
                            resultType: state.type,
                            operationType: state.operationType,
                          );
                          context.read<ResultBloc>().add(event);
                        },
                      ),
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

  String _title(AppLocalizations localizations, ResultLoadedState state) {
    switch (state.type) {
      case OperationResultType.success:
        return localizations.operationSucceededResultTitle(state.operationType.resolve(localizations));
      case OperationResultType.failure:
        return localizations.operationFailedResultTitle(state.operationType.resolve(localizations));
    }
  }
}
