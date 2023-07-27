import 'package:animation/feature/camera/ui/camera_screen.dart';
import 'package:animation/feature/chart/ui/chart_screen.dart';
import 'package:animation/feature/dash_board.dart';
import 'package:animation/feature/main_screen/bloc/bloc/main_screen_bloc.dart';
import 'package:animation/feature/main_screen/repositories/main_screen_repo.dart';
import 'package:animation/feature/main_screen/ui/main_screen.dart';
import 'package:animation/main.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  /*  
    set the global key for button in notification =>
    click to notification => push to main screen
    check temp, humi, ...
  */

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: ((context) => MainScreenBloc(
                  mainScreenRepository: MainScreenRepository(),
                ))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/main': (context) => const MainScreen(),
          '/chart': (context) => const ChartScreen(),
          '/camera': (context) => CameraScreen(cameras: cameras),
        },
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const DashBoardScreen(),
      ),
    );
  }
}
