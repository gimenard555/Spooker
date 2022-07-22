import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

enum AppErrorType {
  Network,
  Bad_Request,
  Unauthorized,
  Cancel,
  Timeout,
  Server,
  Unknown,
  User_Not_Found,
  Password_Wrong,
}

class AppError {
  late String message;
  late AppErrorType type;
  static const userNotFound = 'user-not-found';
  static const passwordWrong = 'wrong-password';

  AppError(Exception? error) {
    var message = '';
    if (error.toString().contains(']')) {
      var getMessage = error.toString().split('] ');
      message = getMessage[1];
    }
    type = AppErrorType.Unknown;
    debugPrint('Error: $message');
    message = message;
  }
}
