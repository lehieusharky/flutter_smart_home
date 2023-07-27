import 'package:animation/feature/main_screen/bloc/bloc/main_screen_bloc.dart';
import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BuildOneSwitchButton extends StatefulWidget {
  final String title;
  final int motorValue;
  final bool isMotor;
  const BuildOneSwitchButton(
      {super.key,
      required this.title,
      required this.motorValue,
      required this.isMotor});

  @override
  State<BuildOneSwitchButton> createState() => _BuildOneSwitchButtonState();
}

class _BuildOneSwitchButtonState extends State<BuildOneSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      // tween: Tween<double>(begin: 0, end: 0.2),
      builder: (BuildContext context, AnimatorState<double> animatorState,
          Widget? child) {
        return SizeTransition(
            sizeFactor: animatorState.animation,
            axis: Axis.horizontal,
            axisAlignment: widget.isMotor ? 1 : -1,
            child: _buildBody());
      },
    );
  }

  Widget _buildBody() {
    return Container(
      width: context.sizeWidth(140),
      height: context.sizeWidth(130),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.motorValue != 0 ? ColorHelper.safeStatus : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSwitchButton(),
          context.sizedBox(height: context.sizeHeight(10)),
          _buildTitle()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: widget.motorValue != 0
          ? TextStyleHelper.titleLightOn
          : TextStyleHelper.titleLightOff,
    );
  }

  Widget _buildSwitchButton() {
    return FlutterSwitch(
      width: 100,
      height: 55,
      toggleSize: 45,
      value: widget.motorValue != 0 ? true : false,
      borderRadius: 30,
      padding: 2.0,
      toggleColor: widget.motorValue != 0
          ? ColorHelper.safeStatus
          : const Color.fromRGBO(225, 225, 225, 1),
      activeColor: Colors.white,
      onToggle: (val) {
        setState(() {
          if (val) {
            BlocProvider.of<MainScreenBloc>(context).add(
                MainScreenUpdateFieldRealtimeValue(
                    widget.isMotor ? 'motor' : 'led', '50'));
          } else {
            BlocProvider.of<MainScreenBloc>(context).add(
                MainScreenUpdateFieldRealtimeValue(
                    widget.isMotor ? 'motor' : 'led', '0'));
          }
        });
      },
    );
  }
}
