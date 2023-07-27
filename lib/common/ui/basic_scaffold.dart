import 'package:animation/common/widgets/background.dart';
import 'package:animation/utils/helper/image_helper.dart';
import 'package:flutter/material.dart';

class BasicScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Size size;
  const BasicScaffold(
      {super.key, required this.body, this.appBar, required this.size});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Stack(children: [
          BackgroundLogin(size: size, imagePath: ImageHelper.background),
          body,
        ]),
      ),
    );
  }
}
