import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../remote/FirestoreConstants.dart';

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
        json[FirestoreConstants.name],
        json[FirestoreConstants.imagePath],
        json[FirestoreConstants.description],
        json[FirestoreConstants.privacy],
        username: json[FirestoreConstants.username],
        userId: json[FirestoreConstants.userId],
      );

  Map<String, dynamic> toMap() => {
        FirestoreConstants.name: name,
        FirestoreConstants.imagePath: imagePath,
        FirestoreConstants.description: description,
        FirestoreConstants.privacy: privacy,
        FirestoreConstants.userId: userId,
        FirestoreConstants.username: username
      };

  factory Artwork.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var event = Artwork.fromMap(doc as Map<String, dynamic>);
    return event;
  }
}
