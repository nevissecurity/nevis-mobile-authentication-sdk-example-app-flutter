// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_bloc.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/blocs/local_data/local_data_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/operation/operation_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/repository/state_repository.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/navigation/global_navigation_manager.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/app_state/operation_result_type.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_event.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/ui/screens/result/result_state.dart';

@injectable
class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final GlobalNavigationManager _globalNavigationManager;
  final LocalDataBloc _localDataBloc;
  final StateRepository<OperationType> _operationTypeStateRepository;

  ResultBloc(
    this._globalNavigationManager,
    this._localDataBloc,
    this._operationTypeStateRepository,
  ) : super(ResultInitialState()) {
    on<ResultCreatedEvent>(_handleCreated);
    on<NavigateToHomeEvent>(_handleNavigateToHome);
  }

  void _handleCreated(ResultCreatedEvent event, Emitter<ResultState> emit) {
    final operationType = _operationTypeStateRepository.state ?? OperationType.unknown;
    emit(ResultLoadedState(
      operationType: operationType,
      type: event.parameter.type,
      description: event.parameter.description,
      errorType: event.parameter.errorType,
    ));
  }

  void _handleNavigateToHome(NavigateToHomeEvent event, Emitter<ResultState> emit) {
    final initClientFailed =
        (event.resultType == OperationResultType.failure && event.operationType == OperationType.init);
    if (initClientFailed == false) {
      _localDataBloc.add(LoadAccountsEvent());
    }
    _operationTypeStateRepository.reset();
    _globalNavigationManager.popUntilHome();
  }
}
