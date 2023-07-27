import 'package:animation/feature/main_screen/child_widgets/build_one_switch_button.dart';
import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:flutter/material.dart';

class BuildButtonMotorAndLed extends StatelessWidget {
  final String motorValue;
  final String ledValue;
  const BuildButtonMotorAndLed(
      {super.key, required this.motorValue, required this.ledValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Motor',
              style: TextStyleHelper.subTitle,
            ),
            Text('LED', style: TextStyleHelper.subTitle),
          ],
        ),
        SizedBox(
          height: context.sizeHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildOneSwitchButton(
              isMotor: true,
              motorValue: int.parse(motorValue),
              title: 'Motor',
            ),
            BuildOneSwitchButton(
              isMotor: false,
              motorValue: int.parse(ledValue),
              title: 'LED',
            )
          ],
        )
      ],
    );
  }
}
