extension StringExtensions on String {
  bool get isNullOrEmpty {
    bool _hasSpace = RegExp(r's').hasMatch(this);
    return this == null || isEmpty || _hasSpace;
  }
}
