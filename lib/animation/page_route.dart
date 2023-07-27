import 'package:flutter/material.dart';

class PageRouteTransition {
  static Route scaleRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder:
          (context, animationControlleranimation, secondaryAnimation, child) {
        final scaleTween = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
              parent: animationControlleranimation, curve: Curves.linear),
        );
        return ScaleTransition(
          scale: scaleTween,
          child: child,
        );
      },
    );
  }

  static Route slideRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleTween = Tween<Offset>(
                begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
            .animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
        );
        return SlideTransition(
          position: scaleTween,
          child: child,
        );
      },
    );
  }
}
