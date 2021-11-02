import 'package:flutter/rendering.dart';

enum AppErrorType {
  NETWORK,
  BAD_REQUEST,
  UNAUTHORIZED,
  CANCEL,
  TIMEOUT,
  SERVER,
  UNKNOWN
}

class AppError {
  late String message;
  late AppErrorType type;
  AppError(Exception? error) {
    debugPrint('Error desconocido: $error');
    type = AppErrorType.UNKNOWN;
    message = 'AppError: $error';
  }
}
