import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/transition_helper.dart';
import 'package:flutter/material.dart';

class BuildBackIconButton extends StatelessWidget {
  const BuildBackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => TrainsitionHelper.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorHelper.temperatureBackground,
          size: 30,
        ));
  }
}
