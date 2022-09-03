import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/reminder.dart';
import 'package:spooker/data/remote/reminder/reminder_data_source.dart';

import '../../model/user.dart';
import '../FirestoreConstants.dart';

class ReminderDataSourceImpl extends ReminderDataSource {
  ReminderDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<Reminder>> getReminders() async {
    var userId = await getUserId();
    var reminders = <Reminder>[];
    await _firebaseFirestore
        .collection(FirestoreConstants.reminderCollection)
        .where(FirestoreConstants.userId, isEqualTo: userId)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              var reminder = Reminder.fromMap(element.data());
              reminder.id = element.id;
              reminders.add(reminder);
            },
          ),
        );
    return reminders;
  }

  @override
  Future<void> createNewReminder(Reminder reminder) async {
    reminder.userId = await getUserId();
    reminder.username = await getUsername();
    await _firebaseFirestore
        .collection(FirestoreConstants.reminderCollection)
        .add(reminder.toMap())
        .then((value) {})
        .catchError((error) {});
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    await _firebaseFirestore
        .collection(FirestoreConstants.reminderCollection)
        .doc(reminderId)
        .delete()
        .then((querySnapshot) {})
        .catchError((error) {});
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    reminder.userId = await getUserId();
    await _firebaseFirestore
        .collection(FirestoreConstants.reminderCollection)
        .doc(reminder.id)
        .update(reminder.toMap())
        .then((querySnapshot) {})
        .catchError((error) {});
  }

  Future<String> getUserId() async {
    var userId = '';
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      userId = querySnapshot.docs.first.id;
    });
    return userId;
  }

  Future<String> getUsername() async {
    var username = '';
    var userId = await getUserId();
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get()
        .then((querySnapshot) {
      username = SpookerUser.fromMap(querySnapshot.data()!).username;
    });
    return username;
  }
}
