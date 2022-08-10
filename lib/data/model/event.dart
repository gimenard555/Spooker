import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Event eventFromMap(String text) => Event.fromMap(json.decode(text));

String eventToMap(Event data) => json.encode(data.toMap());

class Event {
  Event(this._name, this._date, this._hour, this._tag, this._place,
      this._datetime,
      {this.username = '', this.userId = '', this.eventId = ''});

  String _name;

  String get name => _name;

  String _date;

  String get date => _date;

  String _tag;

  String get tag => _tag;

  String userId = '';

  String _place;

  String get place => _place;

  String _hour;

  DateTime? _datetime;

  DateTime? get datetime => _datetime;

  String get hour => _hour;
  String username = '';
  String eventId = '';

  factory Event.fromMap(Map<String, dynamic> json) => Event(
      json['name'],
      json['date'],
      json['hour'],
      json['tags'],
      json['place'],
      (json['datetime'] as Timestamp).toDate(),
      username: json['username']);

  Map<String, dynamic> toMap() => {
        'name': _name,
        'date': _date,
        'hour': _hour,
        'tags': _tag,
        'place': _place,
        'user_id': userId,
        'username': username,
        'datetime': datetime
      };

  factory Event.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var event = Event.fromMap(doc as Map<String, dynamic>);
    return event;
  }
}
