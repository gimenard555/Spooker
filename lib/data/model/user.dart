import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../remote/FirestoreConstants.dart';

SpookerUser userFromMap(String text) => SpookerUser.fromMap(json.decode(text));

String userToMap(SpookerUser data) => json.encode(data.toMap());

class SpookerUser {
  SpookerUser(this.birthdate, this.emailAddress, this.image, this.name,
      this.password, this.username,
      {this.id = ''});

  String username;
  String password;
  String birthdate;
  String emailAddress;
  String image;
  String name;
  String id;

  factory SpookerUser.fromMap(Map<String, dynamic> json) => SpookerUser(
        json[FirestoreConstants.birthdate],
        json[FirestoreConstants.email],
        json[FirestoreConstants.imagePath],
        json[FirestoreConstants.name],
        json[FirestoreConstants.password],
        json[FirestoreConstants.username],
      );

  Map<String, dynamic> toMap() => {
        FirestoreConstants.birthdate: birthdate,
        FirestoreConstants.email: emailAddress,
        FirestoreConstants.imagePath: image,
        FirestoreConstants.name: name,
        FirestoreConstants.password: password,
        FirestoreConstants.username: username,
      };

  factory SpookerUser.fromFirestore(DocumentSnapshot document) {
    var doc = document.data()!;
    var user = SpookerUser.fromMap(doc as Map<String, dynamic>);
    return user;
  }
}
