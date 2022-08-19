import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/model/reminder.dart';
import 'package:spooker/data/model/user.dart';
import 'package:spooker/data/remote/event/event_data_source.dart';

import '../FirestoreConstants.dart';
import '../reminder/reminder_data_source.dart';

class EventDataSourceImpl extends EventDataSource {
  EventDataSourceImpl(this._firestore, this._firebaseAuth, this._dataSource);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final ReminderDataSource _dataSource;

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

  @override
  Future<void> createNewEvent(Event event) async {
    event.userId = await getUserId();
    event.username = await getUsername();
    await _dataSource.createNewReminder(Reminder.fromEvent(event));
    await _firestore
        .collection(FirestoreConstants.eventsCollection)
        .add(event.toMap())
        .then((value) {})
        .catchError((error) {});
  }

  Future<String> getUserId() async {
    var userId = '';
    final currentUser = _firebaseAuth.currentUser;
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      userId = querySnapshot.docs.first.id;
    });
    return userId;
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    await _firestore
        .collection(FirestoreConstants.eventsCollection)
        .doc(eventId)
        .delete()
        .then((querySnapshot) {})
        .catchError((error) {});
  }

  @override
  Future<List<Event>> getMyEvents() async {
    var userId = await getUserId();
    var events = <Event>[];
    await _firestore
        .collection(FirestoreConstants.eventsCollection)
        .where(FirestoreConstants.userId, isEqualTo: userId)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              var event = Event.fromMap(element.data());
              event.eventId = element.id;
              events.add(event);
            },
          ),
        );
    return events;
  }

  @override
  Future<void> updateEvent(Event event) async {
    event.userId = await getUserId();
    event.username = await getUsername();
    await _firestore
        .collection(FirestoreConstants.eventsCollection)
        .doc(event.eventId)
        .update(event.toMap())
        .then((querySnapshot) {})
        .catchError((error) {});
  }

  Future<String> getUsername() async {
    var username = '';
    var userId = await getUserId();
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get()
        .then((querySnapshot) {
      username = SpookerUser.fromMap(querySnapshot.data()!).username;
    });
    return username;
  }

  @override
  Future<List<Event>> getUserEvents(String userId) async {
    var events = <Event>[];
    await _firestore
        .collection(FirestoreConstants.eventsCollection)
        .where(FirestoreConstants.userId, isEqualTo: userId)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              events.add(Event.fromMap(element.data()));
            },
          ),
        );
    return events;
  }
}
