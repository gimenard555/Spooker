import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/remote/event/event_data_source.dart';

class EventDataSourceImpl extends EventDataSource {
  EventDataSourceImpl(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<List<Event>> getEvents() async {
    var events = <Event>[];
    await _firebaseFirestore.collection("event").get().then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              events.add(
                Event.fromMap(element.data()),
              );
            },
          ),
        );
    return events;
  }
}
