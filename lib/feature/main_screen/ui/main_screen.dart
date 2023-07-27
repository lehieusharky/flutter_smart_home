import 'dart:developer';

import 'package:animation/feature/main_screen/child_widgets/build_button_motor_and_led.dart';
import 'package:animation/feature/main_screen/child_widgets/build_frod_motor_and_led.dart';
import 'package:animation/common/widgets/background.dart';
import 'package:animation/common/ui/basic_app_bar.dart';
import 'package:animation/feature/main_screen/bloc/bloc/main_screen_bloc.dart';
import 'package:animation/feature/main_screen/child_widgets/build_parameter.dart';
import 'package:animation/feature/main_screen/repositories/main_screen_repo.dart';
import 'package:animation/lay_out/responsive.dart';
import 'package:animation/model/weather/main_model.dart';
import 'package:animation/model/weather/weather_model.dart';
import 'package:animation/model/weather/wind_model.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/dialog_helper.dart';
import 'package:animation/utils/helper/image_helper.dart';
import 'package:animation/utils/services/position.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _temperatureValue = '0';
  String _humidityValue = "0";
  String _fireAlarm = '0';
  String _smokeAlarm = '0';
  String _motorValue = '0';
  String _ledValue = '0';

  // map to store value from realtime firebase
  Map<String, String> mapRealtimeValue = {};

  AudioCache audioPlayer = AudioCache();
  Position position = const Position(
      longitude: 0,
      latitude: 0,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  WeatherModel weatherModel = WeatherModel(
      weather: [],
      wind: WindModel(speed: 0, deg: 0),
      main: Main(
          temp: 0,
          feelsLike: 0,
          tempMin: 0,
          tempMax: 0,
          pressure: 0,
          humidity: 0,
          seaLevel: 0,
          grndLevel: 0));

  @override
  void initState() {
    super.initState();
    _getPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: BasicAppBar(
            action: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      DialogHelper.showDiaLog(
                          context: context,
                          title: 'Current outdoor weather',
                          dialogType: DialogType.info,
                          message:
                              'Status: ${weatherModel.weather[0].description}\nTemperature: ${(weatherModel.main.temp - 273.5).toStringAsFixed(1)}°C\nHumidity: ${weatherModel.main.humidity}%\nSpeed wind: ${weatherModel.wind.speed} m/s',
                          onPressedOK: () {},
                          iconData: Icons.check,
                          colorOkButton: Colors.blue);
                    },
                    icon: Icon(
                      Icons.cloud,
                      size: 40,
                      color: ColorHelper.safeStatus,
                    )),
              )
            ],
          ),
          body: BlocProvider(
            create: (context) =>
                MainScreenBloc(mainScreenRepository: MainScreenRepository())
                  ..add(MainScreenGetWeatherInformation(
                      position.longitude, position.latitude)),
            child: BlocListener<MainScreenBloc, MainScreenState>(
              listener: (context, state) {
                if (state is MainScreenGetValueSuccess) {
                  /// by stream thread, state is always listen to the change of firebase.
                  mapRealtimeValue = state.mapRealtimeValue;
                  _getRealtimeValue(state);
                }
                if (state is MainScreenGetWeatherInformationSuccess) {
                  weatherModel = state.weatherModel;
                }
              },
              child: BlocBuilder<MainScreenBloc, MainScreenState>(
                builder: (context, state) {
                  return Stack(children: [
                    BackgroundLogin(
                      imagePath: ImageHelper.background,
                      size: size,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: context.sizeHeight(20),
                          ),
                          // temp humidity fire smoke
                          _buildTempHumiFireSmokeInformation(),
                          context.sizedBox(height: context.sizeHeight(50)),
                          // frod motor and led
                          BuildFrodMotorAndLed(
                            ledValue: _ledValue,
                            motorValue: _motorValue,
                          ),
                          context.sizedBox(height: context.sizeHeight(50)),
                          // button motor and led
                          BuildButtonMotorAndLed(
                            ledValue: _ledValue,
                            motorValue: _motorValue,
                          )
                        ],
                      ),
                    ),
                  ]);
                },
              ),
            ),
          )),
    );
  }

  // assign realtime data to local variable
  void _getRealtimeValue(MainScreenGetValueSuccess state) {
    _motorValue = state.mapRealtimeValue['motor'] ?? '0';
    _temperatureValue = state.mapRealtimeValue['temp '] ?? '0';
    _humidityValue = state.mapRealtimeValue['humi'] ?? '0';
    _smokeAlarm = state.mapRealtimeValue['smoke '] ?? '0';
    _fireAlarm = state.mapRealtimeValue['fire'] ?? '0';
    _ledValue = state.mapRealtimeValue['led'] ?? '0';
  }

  Widget _buildTempHumiFireSmokeInformation() {
    return BuildTempHumiFireSmokeParameterWidget(
      humidityValue: _humidityValue,
      temperatureValue: _temperatureValue,
      fireWarmAlarm: _fireAlarm.toString() == '0' ? 0 : 1,
      smokeWarmAlarm: _smokeAlarm == '0' ? 0 : 1,
    );
  }

  void _getPosition() async {
    position = await PositionService.getPosition();
  }
}
