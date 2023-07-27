import 'package:animation/animation/page_route.dart';
import 'package:animation/feature/chart/bloc/bloc/chart_bloc.dart';
import 'package:animation/feature/chart/build_widgets/build_chart.dart';
import 'package:animation/feature/chart/build_widgets/build_row_value.dart';
import 'package:animation/feature/chart/repositories/chart_repo.dart';
import 'package:animation/common/ui/basic_app_bar.dart';
import 'package:animation/common/ui/infor_items.dart';
import 'package:animation/common/widgets/background.dart';
import 'package:animation/model/realtime_value/realtime_model.dart';
import 'package:animation/utils/helper/image_helper.dart';
import 'package:animation/utils/helper/transition_helper.dart';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<RealtimeModel> listItems = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const BasicAppBar(),
        body: BlocProvider(
          create: (context) => ChartBloc(chartRepository: ChartRepository()),
          child: BlocBuilder<ChartBloc, ChartState>(
            builder: (context, state) {
              if (state is ChartGetHourValueSuccess) {
                listItems = state.listItems;
                return Stack(children: [
                  BackgroundLogin(
                    imagePath: ImageHelper.background,
                    size: size,
                  ),
                  Column(
                    children: [
                      // chart
                      buildChart(listItems: listItems),
                      // title of list value
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BuildFieldItemValue(
                            onPressed: () {},
                            time: 'Time',
                            v1: 'Temp ',
                            v2: 'Humility'),
                      ),
                      // list value
                      Expanded(
                          child: Animator(
                        curve: Curves.linear,
                        duration: const Duration(seconds: 1),
                        // tween: Tween<double>(begin: 0, end: 0.2),
                        builder: (BuildContext context,
                            AnimatorState<double> animatorState,
                            Widget? child) {
                          return Opacity(
                              opacity: animatorState.value,
                              child: _listItems());
                        },
                      ))
                    ],
                  ),
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  Widget _listItems() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: listItems.length,
        itemExtent: 50,
        itemBuilder: (context, index) {
          return BuildFieldItemValue(
              onPressed: () {
                _pushToInformationItemsScreen(context, index);
              },
              time: _formatTime(listItems[index].dateTime),
              v2: _formatVolume(listItems[index].humidity),
              v1: _formatVolume(listItems[index].temperature));
        });
  }

  void _pushToInformationItemsScreen(BuildContext context, int index) {
    TrainsitionHelper.nextScreenWithRoute(context,
        route: PageRouteTransition.scaleRoute(BuildInformationItems(
          fire: listItems[index].fire,
          humi: listItems[index].humidity,
          led: listItems[index].led,
          motor: listItems[index].motor,
          smoke: listItems[index].smoke,
          temp: listItems[index].temperature,
          time: listItems[index].dateTime,
        )));
  }

  String _formatVolume(String input) {
    if (input.length == 1) input += ' ';
    return input;
  }
}

String _formatTime(String input) {
  return input.substring(0, 16);
}
