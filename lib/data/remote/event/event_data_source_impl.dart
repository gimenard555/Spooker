import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/model/user.dart';
import 'package:spooker/data/remote/event/event_data_source.dart';

import '../FirestoreConstants.dart';

class EventDataSourceImpl extends EventDataSource {
  EventDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<Event>> getEvents() async {
    var events = <Event>[];
    await _firebaseFirestore
        .collection(FirestoreConstants.eventsCollection)
        .get()
        .then(
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

  @override
  Future<void> createNewEvent(Event event) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      event.userId = querySnapshot.docs.first.id;
    });
    await _firebaseFirestore
        .collection(FirestoreConstants.eventsCollection)
        .add(event.toMap())
        .then((value) {})
        .catchError((error) {});
  }
}
