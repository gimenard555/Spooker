import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/screens/login_screen.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    child: SpookerApp(),
  ));
}

class SpookerApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      /* onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings, firebaseAuth),*/
    );
  }
}
