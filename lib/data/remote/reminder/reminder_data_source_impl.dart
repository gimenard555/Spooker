import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/reminder.dart';
import 'package:spooker/data/remote/reminder/reminder_data_source.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../FirestoreConstants.dart';

class ReminderDataSourceImpl extends ReminderDataSource {
  ReminderDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<Reminder>> getReminders() async {
    final currentUser = _firebaseAuth.currentUser;
    var userId = '';
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      userId = querySnapshot.docs.first.id;
    });
    var reminders = <Reminder>[];
    await _firebaseFirestore
        .collection(FirestoreConstants.reminderCollection)
        .where(FirestoreConstants.user, isEqualTo: userId)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              reminders.add(
                Reminder.fromMap(element.data(), id: element.id),
              );
            },
          ),
        );
    return reminders;
  }

  @override
  Future<void> createNewReminder(Reminder reminder) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      reminder.userId = querySnapshot.docs.first.id;
    });
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
        .then((querySnapshot) {
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print(SpookerErrorStrings.somethingIsWrong));
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      reminder.userId = querySnapshot.docs.first.id;
    });
    await _firebaseFirestore
        .collection(FirestoreConstants.reminderCollection)
        .doc(reminder.reminderId)
        .update(reminder.toMap())
        .then((querySnapshot) {
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print(SpookerErrorStrings.somethingIsWrong));
  }
}
