import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final formTextStateProvider =
    ChangeNotifierProvider((ref) => FormTextFieldStates());

class FormTextFieldStates extends ChangeNotifier {
  bool isRight = true;

  late String _text;
  String get text => _text;
  setText(String text) {
    _text = text;
    validateText();
  }

  void validateText() {
    isRight = true;
    notifyListeners();
  }
}
