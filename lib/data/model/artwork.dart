import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Artwork eventFromMap(String text) => Artwork.fromMap(json.decode(text));

String eventToMap(Artwork data) => json.encode(data.toMap());

class Artwork {
  Artwork(this.name, this.imagePath, this.description, this.privacy);

  String name;
  String imagePath;
  String description;
  String privacy;
  String userName = '';
  String userId = '';
  String id = '';

  factory Artwork.fromMap(Map<String, dynamic> json) => Artwork(
        json['name'],
        json['image_path'],
        json['description'],
        json['privacy'],
        // json['username'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'image_path': imagePath,
        'description': description,
        'privacy': privacy,
        'user_id': userId,
      };

  factory Artwork.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var event = Artwork.fromMap(doc as Map<String, dynamic>);
    return event;
  }
}
