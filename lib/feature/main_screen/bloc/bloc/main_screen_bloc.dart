import 'dart:async';
import 'dart:ffi';

import 'package:animation/feature/main_screen/repositories/main_screen_repo.dart';
import 'package:animation/model/weather/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenRepository mainScreenRepository;

  StreamSubscription<Map<String, String>>? _streamListenVolumeValue;

  MainScreenBloc({required this.mainScreenRepository})
      : super(MainScreenLoading()) {
    on<MainScreenGetValueEvent>(_getValue);
    on<MainScreenUpdateFieldRealtimeValue>(_updateFieldRealtimeValue);
    on<MainScreenGetWeatherInformation>(_getWeatherInformation);

    /// listen realtime value from firebase, push to event
    _streamListenVolumeValue = mainScreenRepository.streamValue.listen((event) {
      add(MainScreenGetValueEvent(mapRealtimeValue: event));
    });
  }

  /// to update led, motor, ....
  Future<void> _updateFieldRealtimeValue(
      MainScreenUpdateFieldRealtimeValue event,
      Emitter<MainScreenState> emit) async {
    try {
      await mainScreenRepository.updateFieldRealtimeValue(
          title: event.title, value: event.value);
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  /// to update led, motor, ....
  Future<void> _getWeatherInformation(MainScreenGetWeatherInformation event,
      Emitter<MainScreenState> emit) async {
    try {
      WeatherModel weatherModel = await mainScreenRepository.fetchWeatherAPI(
          lat: event.lon.toString(), lon: event.lat.toString());
      emit(MainScreenGetWeatherInformationSuccess(weatherModel));
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  /// get realtime value
  Future<void> _getValue(
      MainScreenGetValueEvent event, Emitter<MainScreenState> emit) async {
    try {
      emit(MainScreenGetValueSuccess(mapRealtimeValue: event.mapRealtimeValue));
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamListenVolumeValue?.cancel();
    mainScreenRepository.close();
    return super.close();
  }
}
