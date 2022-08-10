import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Artwork eventFromMap(String text) => Artwork.fromMap(json.decode(text));

String eventToMap(Artwork data) => json.encode(data.toMap());

class Artwork {
  Artwork(this.name, this.imagePath, this.description, this.privacy,
      {this.username = '', this.userId = '', this.id = ''});

  String name;
  String imagePath;
  String description;
  String privacy;
  String username;
  String userId = '';
  String id = '';

  factory Artwork.fromMap(Map<String, dynamic> json) => Artwork(
        json['name'],
        json['image_path'],
        json['description'],
        json['privacy'],
        username: json['username'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'image_path': imagePath,
        'description': description,
        'privacy': privacy,
        'user_id': userId,
        'username': username
      };

  factory Artwork.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var event = Artwork.fromMap(doc as Map<String, dynamic>);
    return event;
  }
}
