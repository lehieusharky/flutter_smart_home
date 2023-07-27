import 'dart:async';

import 'package:animation/feature/chart/repositories/chart_repo.dart';
import 'package:animation/model/realtime_value/realtime_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartRepository chartRepository;

  StreamSubscription<List<RealtimeModel>>? _subscription;

  ChartBloc({required this.chartRepository}) : super(ChartLoading()) {
    on<ChartGetHourValue>(_getHourValue);

    _subscription = chartRepository.streamItem.listen((event) {
      add(ChartGetHourValue(listItems: event));
    });
  }

  // push data from realtime firebase to state
  Future<void> _getHourValue(
      ChartGetHourValue event, Emitter<ChartState> emit) async {
    try {
      emit(ChartGetHourValueSuccess(listItems: event.listItems));
    } catch (e) {
      emit(ChartError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();

    chartRepository.close();
    return super.close();
  }
}
