import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

SpookerUser userFromMap(String text) => SpookerUser.fromMap(json.decode(text));

String userToMap(SpookerUser data) => json.encode(data.toMap());

class SpookerUser {
  SpookerUser(this.birthdate, this.email_address, this.image_path, this.name,
      this.password, this.username);

  String username;
  String password;
  String birthdate;
  String email_address;
  String image_path;
  String name;

  factory SpookerUser.fromMap(Map<String, dynamic> json) => SpookerUser(
        json['birthdate'],
        json['email_address'],
        json['image_path'],
        json['name'],
        json['password'],
        json['username'],
      );

  Map<String, dynamic> toMap() => {
        'birthdate': birthdate,
        'email_address': email_address,
        'image_path': image_path,
        'name': name,
        'password': password,
        'username': username,
      };

  factory SpookerUser.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var user = SpookerUser.fromMap(doc as Map<String, dynamic>);
    return user;
  }
}
