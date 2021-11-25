import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/screen/main_screen.dart';

void main() => runApp(ProviderScope(child: SpookerApp()));

class SpookerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spooker',
      home: MainScreen([Container()]),
    );
  }
}
