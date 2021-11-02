import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spooker',
    );
  }
}
