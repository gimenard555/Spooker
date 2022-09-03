import 'package:cloud_firestore/cloud_firestore.dart';

import '../remote/FirestoreConstants.dart';
import 'event.dart';

class Reminder {
  Reminder(this._date, this._description, this._hour, this._isEvent,
      this._datetime, this._place,
      {this.userId = '', this.id = '', this.username = ''});

  String _date;

  String get date => _date;
  String _description;

  String get description => _description;
  String _hour;

  String get hour => _hour;
  bool _isEvent;

  bool get isEvent => _isEvent;
  DateTime? _datetime;

  DateTime? get datetime => _datetime;

  String _place;

  String get place => _place;

  String userId;
  String username = '';
  String id;

  factory Reminder.fromMap(Map<String, dynamic> json) => Reminder(
      json[FirestoreConstants.date],
      json[FirestoreConstants.description],
      json[FirestoreConstants.hour],
      json[FirestoreConstants.isEvent],
      (json[FirestoreConstants.datetime] as Timestamp).toDate(),
      json[FirestoreConstants.place],
      userId: json[FirestoreConstants.userId],
      username: json[FirestoreConstants.username]);

  Map<String, dynamic> toMap() => {
        FirestoreConstants.date: _date,
        FirestoreConstants.description: _description,
        FirestoreConstants.hour: _hour,
        FirestoreConstants.isEvent: _isEvent,
        FirestoreConstants.datetime: _datetime,
        FirestoreConstants.place: _place,
        FirestoreConstants.userId: userId,
        FirestoreConstants.username: username
      };

  factory Reminder.fromEvent(Event event) => Reminder(
      event.date, event.name, event.hour, true, event.datetime, event.place,
      userId: event.userId);

  factory Reminder.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var reminder = Reminder.fromMap(doc as Map<String, dynamic>);
    return reminder;
  }
}
