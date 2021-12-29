import 'package:flutter/cupertino.dart';

@immutable
class SpookerStrings {
  static const welcomeSignUpText =
      'Create your personal account so you can know new friends';
  static const welcomeSignInText =
      'Enter in your account and share your artworks with friends';
  static const signInText = 'Sign In';
  static const signUpText = 'Create Your Account';
  static const spookerAppName = 'Spooker';
  static const emailAddressText = 'Email Address';
  static const usernameText = 'Username';
  static const birthdateText = 'Birthdate';
  static const passwordText = 'Password';
  static const confirmPasswordText = 'Confirm Password';
  static const GoogleButtonText = 'Sign in with Google';
  static const ContinueButtonText = 'Continue';
  static const birthdateSelectionText = 'Select your birthdate';
  static const dateSelectionButtonText = 'Select date';
}

@immutable
class SpookerErrorStrings {
  static const emailErrorText = 'Enter a valid email address';
  static const passwordErrorText = "Enter a valid password\n"
      "Minimum 1 Upper case\n"
      "Minimum 1 lowercase\n"
      "Minimum 1 Numeric Number\n"
      "Minimum 1 Special Character\n";
  static const dateErrorText = 'Enter a valid date';
  static const passwordMatch = 'Passwords do not match';
}
