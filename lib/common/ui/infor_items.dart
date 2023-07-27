import 'package:animation/lay_out/responsive.dart';
import 'package:animation/utils/helper/color_helper.dart';
import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:animation/utils/helper/transition_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class BuildInformationItems extends StatefulWidget {
  final String temp;
  final String humi;
  final String fire;
  final String smoke;
  final String motor;
  final String led;
  final String time;
  const BuildInformationItems(
      {super.key,
      required this.temp,
      required this.humi,
      required this.fire,
      required this.smoke,
      required this.motor,
      required this.led,
      required this.time});

  @override
  State<BuildInformationItems> createState() => _BuildInformationItemsState();
}

class _BuildInformationItemsState extends State<BuildInformationItems> {
  Map<String, String> mapValue = {};
  Set<String> setKey = {};
  List<String> listValue = [];
  List<String> listTitle = [
    'Temperature',
    'Humidity',
    'Fire',
    'Smoke',
    'Motor',
    'Led'
  ];

  List<IconData> listIcon = [
    Ionicons.thermometer_sharp,
    Ionicons.water_sharp,
    Ionicons.bonfire,
    Icons.cloud,
    Ionicons.speedometer,
    Icons.light,
  ];

  List<Color> listColor = [
    const Color(0xFFF14D66),
    const Color(0xff769FCD),
    const Color(0xffE06469),
    const Color(0xff537188),
    const Color(0xff10A19D),
    const Color(0xffFFBF00),
  ];

  @override
  void initState() {
    super.initState();
    mapValue = {
      'temp': widget.temp,
      'humi': widget.humi,
      'fire': widget.fire == '0' ? 'Safe' : 'Danger',
      'smoke': widget.smoke == '0' ? 'Safe' : 'Danger',
      'motor': widget.motor,
      'led': widget.led,
      'time': widget.time
    };
    mapValue.forEach((key, value) {
      setKey.add(key);
      listValue.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => TrainsitionHelper.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorHelper.temperatureBackground,
              size: 30,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Information Items', style: TextStyleHelper.titleLightOff),
      ),
      body: Column(
        children: [
          context.sizedBox(height: context.sizeHeight(30)),
          // time
          Text(
            'Time: ${_formatTime(mapValue['time'] ?? '')}',
            style: TextStyleHelper.hintTextOfTextFormField,
          ),
          context.sizedBox(height: context.sizeHeight(30)),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemExtent: context.sizeHeight(120),
                  itemCount: listTitle.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        verticalOffset: -250,
                        child: ScaleAnimation(
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: _buildFieldValue(
                              size: size,
                              title: listTitle[index],
                              color: listColor[index],
                              value: listValue[index],
                              icon: listIcon[index]),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldValue(
      {required Size size,
      required Color color,
      required String value,
      required IconData icon,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: size.width,
        height: context.sizeHeight(100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            Text(
              ' $title : ',
              style: TextStyleHelper.titleLightOn,
            ),
            Text(
              value,
              style: TextStyleHelper.titleLightOn,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String input) {
    return input.substring(0, 16);
  }
}
