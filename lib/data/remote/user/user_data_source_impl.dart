import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/remote/user/user_data_source.dart';

class UserDataSourceImpl extends UserDataSource {
  UserDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;


}
