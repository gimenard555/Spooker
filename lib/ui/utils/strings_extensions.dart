extension StringExtensions on String {
  bool get isNullOrEmpty {
    bool _hasSpace = RegExp(r's').hasMatch(this);
    return isEmpty || _hasSpace;
  }

  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
