import 'package:animation/feature/dash_board.dart';
import 'package:animation/common/ui/basic_app_bar.dart';
import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/dialog_helper.dart';
import 'package:animation/utils/helper/transition_helper.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  bool isShow = false;
  int frameCount = 0;
  int count = 0;
  String filePath = '';
  int second = 0;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SizedBox(
        height: context.sizeHeight(650),
        child: Zoom(
          colorScrollBars: ColorHelper.safeStatus,
          maxZoomWidth: size.width,
          maxZoomHeight: size.height * 0.8,
          backgroundColor: Colors.transparent,
          child: CameraPreview(
            controller,
          ),
        ),
      ),
    );
  }

  void _showCameraException() {
    DialogHelper.showException(
        context: context,
        title: 'OHH Failure',
        message: 'Camera access denied',
        onPressedOK: () {
          TrainsitionHelper.nextScreenReplace(context, const DashBoardScreen());
        });
  }

  void _initCamera() {
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            _showCameraException();
            break;
          default:
            break;
        }
      }
    });
  }
}
