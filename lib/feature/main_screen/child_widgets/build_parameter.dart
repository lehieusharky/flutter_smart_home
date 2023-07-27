import 'package:animation/feature/main_screen/child_widgets/build_one_items.dart';
import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BuildTempHumiFireSmokeParameterWidget extends StatelessWidget {
  final String temperatureValue;
  final String humidityValue;
  final int fireWarmAlarm;
  final int smokeWarmAlarm;
  const BuildTempHumiFireSmokeParameterWidget(
      {super.key,
      required this.temperatureValue,
      required this.humidityValue,
      required this.fireWarmAlarm,
      required this.smokeWarmAlarm});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: context.sizeHeight(180),
        decoration: BoxDecoration(
            color: const Color(0xffF6F1F1),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 2), // change
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              // temperature  and humidity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildOneItems(
                    width: context.sizeWidth(150),
                    height: context.sizeHeight(70),
                    isTemp: true,
                    alarm: 0,
                    isWarm: false,
                    icon: const Icon(
                      Ionicons.thermometer_sharp,
                      color: Colors.red,
                      size: 30,
                    ),
                    value: temperatureValue,
                    unit: '℃ ',
                  ),
                  BuildOneItems(
                    width: context.sizeWidth(150),
                    height: context.sizeHeight(70),
                    isTemp: false,
                    alarm: 0,
                    isWarm: false,
                    icon: Icon(
                      Ionicons.water_sharp,
                      color: ColorHelper.safeStatus,
                      size: 30,
                    ),
                    value: humidityValue,
                    unit: '% ',
                  ),
                ],
              ),
              // fire and smoke
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildOneItems(
                    isTemp: false,
                    alarm: fireWarmAlarm,
                    isWarm: true,
                    width:context.sizeWidth(150),
                    height: context.sizeHeight(70),
                    icon: fireWarmAlarm == 0
                        ? const Icon(Ionicons.checkmark_circle_sharp,
                            color: Colors.white, size: 30)
                        : const Icon(Ionicons.warning_sharp,
                            color: Colors.white, size: 30),
                    value: ' Fire',
                    unit: '',
                  ),
                  BuildOneItems(
                    isTemp: false,
                    alarm: smokeWarmAlarm,
                    isWarm: true,
                    width: context.sizeWidth(150),
                    height: context.sizeHeight(70),
                    icon: smokeWarmAlarm == 0
                        ? const Icon(Ionicons.checkmark_circle_sharp,
                            color: Colors.white, size: 30)
                        : const Icon(Ionicons.warning_sharp,
                            color: Colors.white, size: 30),
                    value: ' Smoke',
                    unit: '',
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
