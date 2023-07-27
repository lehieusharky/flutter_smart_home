import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:flutter/material.dart';

class BuildFieldItemValue extends StatelessWidget {
  final void Function()? onPressed;
  final String time;
  final String v1;
  final String v2;

  const BuildFieldItemValue(
      {Key? key,
      required this.time,
      required this.v1,
      required this.v2,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: ColorHelper.safeStatus,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: context.sizeWidth(150),
              child: Text(
                time,
                style: TextStyleHelper.subTitle,
                textAlign: TextAlign.center,
              )),
          SizedBox(
              width: context.sizeWidth(80),
              child: Text(
                v1,
                style: TextStyleHelper.subTitle,
                textAlign: TextAlign.center,
              )),
          SizedBox(
              width:  context.sizeWidth(80),
              child: Text(
                v2,
                style: TextStyleHelper.subTitle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
