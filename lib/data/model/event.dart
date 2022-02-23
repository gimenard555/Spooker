import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Event eventFromMap(String text) => Event.fromMap(json.decode(text));

String eventToMap(Event data) => json.encode(data.toMap());

class Event {
  Event(this.name, this.date, this.tags, this.userName, this.imagePath);

  String name;
  String date;
  String tags;
  String userName;
  String imagePath;

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        json['name'],
        json['date'],
        json['tags'],
        json['userName'],
        json['image_path'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'date': date,
        'tags': tags,
        'userName': userName,
        'image_path': imagePath,
      };

  factory Event.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var event = Event.fromMap(doc as Map<String, dynamic>);
    return event;
  }
}
