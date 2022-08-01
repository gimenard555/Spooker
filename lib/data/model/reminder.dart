import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  Reminder(
      this._date, this._description, this._hour, this._isEvent, this._datetime,
      {this.userId = ''});

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
  String? userId;

  factory Reminder.fromMap(Map<String, dynamic> json) => Reminder(
        json['date'],
        json['description'],
        json['hour'],
        json['is_event'],
        json['datetime'],
        userId: json['user'],
      );

  Map<String, dynamic> toMap() => {
        'date': _date,
        'description': _description,
        'hour': _hour,
        'is_event': _isEvent,
        'datetime': _datetime,
        'user': userId
      };

  factory Reminder.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var reminder = Reminder.fromMap(doc as Map<String, dynamic>);
    return reminder;
  }
}
