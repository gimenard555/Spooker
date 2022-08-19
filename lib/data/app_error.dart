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
  String message = '';
  AppErrorType type;
  static const userNotFound = 'user-not-found';
  static const passwordWrong = 'wrong-password';

  AppError(Exception? error,
      {this.message = '', this.type = AppErrorType.Bad_Request}) {
    var message = '';
    if (error.toString().contains(']')) {
      var getMessage = error.toString().split('] ');
      message = getMessage[1];
    }
    type = AppErrorType.Unknown;
    message = message;
  }
}
