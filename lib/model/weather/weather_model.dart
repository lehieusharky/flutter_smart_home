import 'package:animation/model/weather/main_model.dart';
import 'package:animation/model/weather/weather.dart';
import 'package:animation/model/weather/wind_model.dart';

class WeatherModel {
  final List<Weather> weather;
  final Main main;
  final WindModel wind;

  WeatherModel( {
    required this.wind,
    required this.weather,
    required this.main,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = <Weather>[];
    json['weather'].forEach((v) {
      weather.add(Weather.fromJson(v));
    });
    final main = Main.fromJson(json['main']);

    final wind = WindModel.fromJson(json['wind']);

    return WeatherModel(weather: weather, main: main, wind: wind);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['weather'] = weather.map((v) => v.toJson()).toList();

    data['main'] = main.toJson();
    return data;
  }
}


