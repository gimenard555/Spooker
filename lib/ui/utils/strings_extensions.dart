extension StringExtensions on String {
  bool get isNullOrEmpty {
    bool _hasSpace = RegExp(r's').hasMatch(this);
    return isEmpty || _hasSpace;
  }
}
