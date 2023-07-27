import 'package:animation/feature/main_screen/child_widgets/build_one_motor.dart';
import 'package:flutter/material.dart';

class BuildFrodMotorAndLed extends StatelessWidget {
  final String motorValue;
  final String ledValue;
  const BuildFrodMotorAndLed(
      {super.key, required this.motorValue, required this.ledValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BuildOneMotor(
          isMotor: true,
          motorValue: int.parse(motorValue),
        ),
        // led
        BuildOneMotor(
          isMotor: false,
          motorValue: int.parse(ledValue),
        ),
      ],
    );
  }
}
