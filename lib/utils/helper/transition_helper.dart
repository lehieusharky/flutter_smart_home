import 'package:flutter/material.dart';

class TrainsitionHelper {
  static void nextScreen(context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void nextScreenWithRoute(context, {required Route route}) {
    Navigator.of(context).push(route);
  }

  static void nextScreenReplace(context, screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(context) {
    Navigator.pop(context);
  }
}
