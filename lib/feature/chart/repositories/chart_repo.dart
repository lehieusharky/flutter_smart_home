import 'dart:async';

import 'package:animation/model/realtime_value/realtime_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenItem;
  final StreamController<List<RealtimeModel>> _streamItems =
      StreamController.broadcast();

  Stream<List<RealtimeModel>> get streamItem => _streamItems.stream;

  ChartRepository() {
    // get data from 'hour' collection
    _listenItem =
        _store.collection('hour').snapshots().listen((snapshot) async {
      final itemSnapshot = await _store.collection('hour').get();
      final listItems = itemSnapshot.docs
          .map((doc) => RealtimeModel.fromJson(doc.data()))
          .toList();
      _streamItems.add(listItems);
    });
  }

  void close() {
    _listenItem?.cancel();
    _streamItems.close();
  }
}
