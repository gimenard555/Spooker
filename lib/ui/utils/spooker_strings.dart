import 'package:flutter/cupertino.dart';

@immutable
class SpookerStrings {
  static const emptyString = '';
  static const spookerAppName = 'Spooker';
  static const firstScreenText =
      'Start sharing your artworks with your friends';
  static const welcomeSignUpText =
      'Create your personal account so you can know new friends';
  static const welcomeSignInText =
      'Enter in your account and share your artworks with friends';
  static const loginText = 'Login';
  static const signInText = 'Sign In';
  static const signInGoogleText = 'Sign in with Google';
  static const signUpText = 'Create Your Account';
  static const emailAddressText = 'Email Address';
  static const passwordForgotten = 'Forgot your password?';
  static const usernameText = 'Username';
  static const birthdateText = 'Birthdate';
  static const passwordText = 'Password';
  static const confirmPasswordText = 'Confirm Password';
  static const GoogleButtonText = 'Sign in with Google';
  static const ContinueButtonText = 'Continue';
  static const birthdateSelectionText = 'Select your birthdate';
  static const dateSelectionButtonText = 'Select date';
  static const artworksText = 'Artworks';
  static const eventsText = 'Events';
  static const continueText = 'Continue';
  static const editText = 'Edit';
  static const spookerExit = 'X';
  static const newSpooker = 'New Spooker';
  static const newArtwork = 'New Artwork';
  static const newReminder = 'New Reminder';
  static const eventTitle = 'Event Title';
  static const eventDate = 'Event Date';
  static const eventPlace = 'Event Place';
  static const reminderTitle = 'Reminder Title';
  static const reminderDate = 'Reminder Date';
  static const artworkTitle = 'Artwork name';
  static const artworkDescription = 'Artwork description';
  static const reminderHour = 'Reminder Hour';
  static const reminderPlace = 'Reminder Place (Optional)';
  static const tagType = 'Tag Type';
  static const privacyType = 'Privacy Type';
  static const emptySpooker = 'There are no live spookers right now';
  static const reminders = 'Reminders';
  static const reminder = 'Reminder';
  static const delete = 'Delete';
  static const edit = 'Edit';
  static const deleteMessage = 'Are you sure do you want to delete your';
  static const deleteWarning = 'Once deleted it cannot be recovered';
  static const imageOptionTitle = 'Select artwork picture source';
  static const takePicture = 'Take picture';
  static const selectFromYourGallery = 'Select from your gallery';
  static const yourArtworkImage = 'Your Artwork Image';
  static const artwork = 'Artwork';
}

@immutable
class SpookerErrorStrings {
  static const error = 'ERROR';
  static const emailErrorText = 'Enter a valid email address';
  static const passwordErrorText = "Enter a valid password\n"
      "Minimum 1 Upper case\n"
      "Minimum 1 lowercase\n"
      "Minimum 1 Numeric Number\n"
      "Minimum 1 Special Character\n";
  static const dateErrorText = 'Enter a valid date';
  static const passwordMatch = 'Passwords do not match';
  static const somethingIsWrong = 'something is wrong';
  static const dialogWrong =
      'Something went wrong with the username or password. please enter them again';
}
