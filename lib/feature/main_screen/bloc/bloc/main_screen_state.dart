part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

class MainScreenLoading extends MainScreenState {}

class MainScreenGetValueSuccess extends MainScreenState {
  final Map<String, String> mapRealtimeValue;

  const MainScreenGetValueSuccess({required this.mapRealtimeValue});

  @override
  List<Object> get props => [mapRealtimeValue];
}

class MainScreenGetWeatherInformationSuccess extends MainScreenState {
  final WeatherModel weatherModel;

  const MainScreenGetWeatherInformationSuccess(this.weatherModel);

  @override
  List<Object> get props => [weatherModel];
}

class MainScreenError extends MainScreenState {
  final String error;

  const MainScreenError({required this.error});

  @override
  List<Object> get props => [error];
}
