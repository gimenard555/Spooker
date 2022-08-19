import 'package:cloud_firestore/cloud_firestore.dart';

import 'event.dart';

class Reminder {
  Reminder(this._date, this._description, this._hour, this._isEvent,
      this._datetime, this._place,
      {this.userId = '', this.id = ''});

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
  String id;

  factory Reminder.fromMap(Map<String, dynamic> json) => Reminder(
      json['date'],
      json['description'],
      json['hour'],
      json['is_event'],
      (json['datetime'] as Timestamp).toDate(),
      json['place'],
      userId: json['user_id']);

  Map<String, dynamic> toMap() => {
        'date': _date,
        'description': _description,
        'hour': _hour,
        'is_event': _isEvent,
        'datetime': _datetime,
        'place': _place,
        'user_id': userId
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
