import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class BuildOneItems extends StatelessWidget {
  final String value;
  final Icon icon;
  final String unit;
  final double? width;
  final double? height;
  final bool isTemp;
  final bool isWarm;
  final int alarm;
  const BuildOneItems({
    super.key,
    required this.value,
    required this.icon,
    required this.unit,
    this.width,
    this.height,
    required this.isWarm,
    required this.alarm,
    required this.isTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.bounceOut,
      duration: const Duration(seconds: 1),
      tween: Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)),
      builder: (BuildContext context, AnimatorState<Offset> animatorState,
          Widget? child) {
        return FractionalTranslation(
          translation: animatorState.value,
          child: _buildWidget(
            alarm: alarm,
            height: height,
            icon: icon,
            isTemp: isTemp,
            isWarm: isWarm,
            unit: unit,
            value: value,
            width: width,
          ),
        );
      },
    );
  }
}

Widget _buildWidget({
  required String value,
  required Icon icon,
  required String unit,
  required double? width,
  required double? height,
  required bool isTemp,
  required bool isWarm,
  required int alarm,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2), // change
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: isWarm
            ? (alarm == 0
                ? ColorHelper.safeStatus
                : ColorHelper.dangerousStatus)
            : (isTemp
                ? (int.parse(value) > 35
                    ? Colors.red
                    : ColorHelper.temperatureBackground)
                : (int.parse(value) > 70
                    ? Colors.red
                    : ColorHelper.temperatureBackground))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(
          '$value $unit',
          style:
              isWarm ? TextStyleHelper.titleWarming : TextStyleHelper.itemValue,
        ),
      ],
    ),
  );
}
