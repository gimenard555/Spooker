import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Event eventFromMap(String text) => Event.fromMap(json.decode(text));

String eventToMap(Event data) => json.encode(data.toMap());

class Event {
  Event(this.name, this.date, this.tags, this.userName, this.description);

  String name;
  String date;
  String tags;
  String userName;
  String description;

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        json['name'],
        json['date'],
        json['tags'],
        json['user_name'],
        json['description'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'date': date,
        'tags': tags,
        'userName': userName,
        'description': description,
      };

  factory Event.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var event = Event.fromMap(doc as Map<String, dynamic>);
    return event;
  }
}
