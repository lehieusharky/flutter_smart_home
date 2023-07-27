import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:animation/model/weather/main_model.dart';
import 'package:animation/model/weather/weather_model.dart';
import 'package:animation/model/weather/wind_model.dart';
import 'package:animation/utils/helper/text_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
class MainScreenRepository {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  final weatherURL = 'https://api.openweathermap.org/data/2.5/weather?';

  final String baseUrl = 'https://api.mangadex.org/manga';

  StreamSubscription<DatabaseEvent>? _listenValue;
  final StreamController<Map<String, String>> _streamValue =
      StreamController.broadcast();

  Stream<Map<String, String>> get streamValue => _streamValue.stream;

  MainScreenRepository() {
    _listenValue = databaseReference.onValue.listen((event) {
      Map<String, String> mapRealtimeValue = {};
      // listen change of value on firebase and push to stream
      Map<String, dynamic>.from(event.snapshot.value as dynamic)
          .forEach((key, value) {
        mapRealtimeValue.addEntries([MapEntry(key, value)]);
      });
      _streamValue.add(mapRealtimeValue);
    });
  }

  /// update realtime value
  Future<void> updateFieldRealtimeValue(
      {required String title, required String value}) async {
    await databaseReference.update({
      title: value,
    });
  }

  Future<WeatherModel> fetchWeatherAPI({required String lat, required String lon}) async {
    try {
      WeatherModel weatherModel = WeatherModel(
          weather: [],
          wind: WindModel(speed: 0, deg: 0),
          main: Main(
              temp: 0,
              feelsLike: 0,
              tempMin: 0,
              tempMax: 0,
              pressure: 0,
              humidity: 0,
              seaLevel: 0,
              grndLevel: 0));
      final response = await http.get(Uri.parse('${weatherURL}lat=$lat&lon=$lon&appid=${TextHelper.apiWeatherKey}'), headers: {});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        weatherModel = WeatherModel.fromJson(jsonResponse);
      } else {
        log(response.statusCode.toString());
      }
      return weatherModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<void> pushMessageNotification(
  //     {required String messageToken, required String message}) async {
  //   try {
  //     final body = {
  //       "to": messageToken,
  //       "notification": {
  //         "title": 'Warming!!!',
  //         //our name should be send
  //         "body": message,
  //         "android_channel_id": "warming"
  //       },
  //     };

  //     await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json',
  //           HttpHeaders.authorizationHeader:
  //               'key=${TextHelper.serviceKeyFirebaseMessage}'
  //         },
  //         body: jsonEncode(body));
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // // get firebase message token
  // Future<void> _getFirebaseMessagingToken() async {
  //   await _firebaseMessaging.requestPermission();

  //   await _firebaseMessaging.getToken().then((token) {
  //     if (token != null) {
  //       _firebaseFirestore
  //           .collection('token')
  //           .doc('user_token')
  //           .update({'push_token': token});
  //     }
  //   });
  // }

  void close() {
    _listenValue!.cancel();
    _streamValue.close();
  }
}
