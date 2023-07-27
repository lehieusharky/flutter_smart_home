part of 'chart_bloc.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();

  @override
  List<Object> get props => [];
}

class ChartGetHourValue extends ChartEvent {
  final List<RealtimeModel> listItems;

  const ChartGetHourValue({required this.listItems});

  @override
  List<Object> get props => [listItems];
}
