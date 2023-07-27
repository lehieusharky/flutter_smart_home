part of 'chart_bloc.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

class ChartLoading extends ChartState {}

class ChartGetHourValueSuccess extends ChartState {
  final List<RealtimeModel> listItems;

  const ChartGetHourValueSuccess({required this.listItems});

  @override
  List<Object> get props => [listItems];
}

class ChartError extends ChartState {
  final String error;
  const ChartError({required this.error});

  @override
  List<Object> get props => [error];
}
