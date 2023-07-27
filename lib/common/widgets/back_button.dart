import 'package:animation/utils/helper/color_helper.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios,
            color: ColorHelper.temperatureBackground, size: 50),
        onPressed: onPressed);
  }
}
