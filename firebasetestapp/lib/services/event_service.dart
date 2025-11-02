import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_detail.dart';

class EventService {
  final _db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('event_details');

  /// One-shot fetch (Future)
  Future<List<EventDetail>> fetchOnce() async {
    final snap = await _col.get();
    return snap.docs
        .map((d) => EventDetail.fromMap(d.data(), d.id))
        .toList();
  }

  /// Live updates (Stream)
  Stream<List<EventDetail>> streamAll() {
    return _col.orderBy('date').snapshots().map(
          (snap) => snap.docs
              .map((d) => EventDetail.fromMap(d.data(), d.id))
              .toList(),
        );
  }
}
