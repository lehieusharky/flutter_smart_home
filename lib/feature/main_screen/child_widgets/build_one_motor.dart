import 'package:animation/feature/main_screen/bloc/bloc/main_screen_bloc.dart';
import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knob_widget/knob_widget.dart';

class BuildOneMotor extends StatefulWidget {
  final int motorValue;
  final bool isMotor;
  const BuildOneMotor(
      {super.key, required this.motorValue, required this.isMotor});

  @override
  State<BuildOneMotor> createState() => _BuildOneMotorState();
}

class _BuildOneMotorState extends State<BuildOneMotor> {
  bool isLoaded = false;
  String msg = '';
  double pos = 0;
  double speed = 10;
  final double _minimum = 0;
  final double _maximum = 100;
  late KnobController _controller;

  @override
  void initState() {
    super.initState();
    // set knod controller infor
    _setKnodController();
    //
    _controller.addOnValueChangedListener(valueChangedListener);
    //
  }

  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.elasticOut,
      duration: const Duration(seconds: 1),
      // tween: Tween<double>(begin: 0, end: 0.2),
      builder: (BuildContext context, AnimatorState<double> animatorState,
          Widget? child) {
        return Transform.scale(
          scale: animatorState.value,
          child: Stack(alignment: Alignment.center, children: [
            Knob(
              controller: _controller,
              width: context.sizeWidth(120),
              height: context.sizeWidth(120),
              style: const KnobStyle(
                showMinorTickLabels: true,
                labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                tickOffset: 0, // khoang cach tick vs circle
                labelOffset: -10, // khoang cach label vs tick
                minorTicksPerInterval: 3, // so luong node
              ),
            ),
            Text(
              widget.motorValue.toString(),
              style: TextStyleHelper.motorValue,
            ),
          ]),
        );
      },
    );
  }

  void valueChangedListener(double value) {
    if (mounted) {
      setState(() {
        BlocProvider.of<MainScreenBloc>(context).add(
            MainScreenUpdateFieldRealtimeValue(
                widget.isMotor ? 'motor' : 'led', value.round().toString()));

        //  _controller.setCurrentValue(value);
      });
    }
  }

  void _setKnodController() {
    _controller = KnobController(
      initial: widget.motorValue * 1.0,
      minimum: _minimum,
      maximum: _maximum,
      startAngle: 0,
      endAngle: 350,
    );
  }

  @override
  void dispose() {
    _controller.removeOnValueChangedListener(valueChangedListener);
    super.dispose();
  }
}
