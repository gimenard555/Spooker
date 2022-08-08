import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/model/user.dart';
import 'package:spooker/data/remote/event/event_data_source.dart';

import '../FirestoreConstants.dart';

class EventDataSourceImpl extends EventDataSource {
  EventDataSourceImpl(this._firestore, this._firebaseAuth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<Event>> getEvents() async {
    var events = <Event>[];
    await _firestore.collection(FirestoreConstants.eventsCollection).get().then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              events.add(Event.fromMap(element.data()));
            },
          ),
        );
    return events;
  }

  Future<List<Event>> getListUserNameById(List<Event> events) async {
    for(int i = 0; i<events.length; i++){
      events[i].userName = await getUserNameById(events[i].userId);
    }
    return events;
  }

  Future<String> getUserNameById(String userId) async {
    var username = '';
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get()
        .then((querySnapshot) {
      username = SpookerUser.fromMap(querySnapshot.data()!).name;
    });
    return username;
  }

  @override
  Future<void> createNewEvent(Event event) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      event.userId = querySnapshot.docs.first.id;
    });
    await _firestore
        .collection(FirestoreConstants.eventsCollection)
        .add(event.toMap())
        .then((value) {})
        .catchError((error) {});
  }
}
