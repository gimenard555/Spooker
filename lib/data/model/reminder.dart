import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  Reminder(this._date, this._description, this._hour, this._isEvent,
      this._datetime, this._place,
      {this.userId = '', this.reminderId = ''});

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
  String reminderId;

  factory Reminder.fromMap(Map<String, dynamic> json,
          {String id = '', String name = ''}) =>
      Reminder(
          json['date'],
          json['description'],
          json['hour'],
          json['is_event'],
          (json['datetime'] as Timestamp).toDate(),
          json['place'],
          userId: json['user'],
          reminderId: id);

  Map<String, dynamic> toMap() => {
        'date': _date,
        'description': _description,
        'hour': _hour,
        'is_event': _isEvent,
        'datetime': _datetime,
        'place': _place,
        'user': userId
      };

  factory Reminder.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var reminder = Reminder.fromMap(doc as Map<String, dynamic>);
    return reminder;
  }
}
