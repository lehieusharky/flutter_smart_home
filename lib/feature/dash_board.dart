import 'package:animation/feature/chart/ui/chart_screen.dart';
import 'package:animation/feature/main_screen/repositories/main_screen_repo.dart';
import 'package:animation/feature/main_screen/ui/main_screen.dart';
import 'package:animation/feature/camera/ui/camera_screen.dart';
import 'package:animation/main.dart';
import 'package:animation/utils/services/notification.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/sound_helper.dart';
import 'package:animation/utils/services/position.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:vibration/vibration.dart';

import 'main_screen/bloc/bloc/main_screen_bloc.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _page = 1;
  AudioCache audioPlayer = AudioCache();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final tab = [
    CameraScreen(cameras: cameras),
    const MainScreen(),
    const ChartScreen(),
  ];

  Position? position = const Position(
      longitude: 0,
      latitude: 0,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPosition();
  }

  void _getPosition() async {
    position = await PositionService.getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainScreenBloc, MainScreenState>(
      listener: (context, state) {
        if (state is MainScreenGetValueSuccess) {
          // listen realtime databse
          // if fire's value or smoke'value is 1 => warming
          _warming(
              fireAlarm: state.mapRealtimeValue['fire'] ?? '0',
              smokeAlarm: state.mapRealtimeValue['smoke '] ?? '0');
        }
      },
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 1,
            height: 60.0,
            items: [
              // icon of navigation
              _buildIconNavigationBar(icon: Ionicons.camera, index: 0),
              _buildIconNavigationBar(icon: Ionicons.water, index: 1),
              _buildIconNavigationBar(icon: Ionicons.bar_chart, index: 2),
            ],
            color: ColorHelper.safeStatus,
            buttonBackgroundColor: ColorHelper.safeStatus,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 400),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: tab[_page]),
    );
  }

  Widget _buildIconNavigationBar({required IconData icon, required int index}) {
    return Icon(
      icon,
      size: 30,
      color: Colors.white,
    );
  }

  /// vibrate and play warming sound
  void _warming({required String fireAlarm, required String smokeAlarm}) {
    if (fireAlarm == "1") {
      Vibration.vibrate(duration: 5000);
      audioPlayer.play(SoundHelper.fireAlarm);
      _pushNotification();
    }
    if (smokeAlarm == '1') {
      Vibration.vibrate(duration: 5000);
      audioPlayer.play(SoundHelper.smokeAlarm);
      _pushNotification();
    }
  }

  Future<void> _pushNotification() async {
    await NotificationService.showNotification(
      bigPicture: '',
      title: 'Warming',
      body: 'Check the device now!!!',
      payload: {
        "navigate": "true",
      },
      actionButtons: [
        NotificationActionButton(
          key: 'check',
          label: 'Check',
          actionType: ActionType.SilentAction,
        )
      ],
    );
  }
}
