part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MainScreenGetValueEvent extends MainScreenEvent {
  final Map<String, String> mapRealtimeValue;

  MainScreenGetValueEvent({required this.mapRealtimeValue});

  @override
  List<Object> get props => [mapRealtimeValue];
}

class MainScreenGetWeatherInformation extends MainScreenEvent {
  final double lon;
  final double lat;

  MainScreenGetWeatherInformation(this.lon, this.lat);
  @override
  List<Object> get props => [lon, lat];
}
class MainScreenUpdateFieldRealtimeValue extends MainScreenEvent {
  final String title;
  final String value;

  MainScreenUpdateFieldRealtimeValue(this.title, this.value);

  @override
  List<Object> get props => [title, value];
}
