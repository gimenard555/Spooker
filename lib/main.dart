import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/screens/create_account_screen.dart';
import 'package:spooker/ui/screens/login_screen.dart';
import 'package:spooker/ui/utils/spooker_routes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(
    child: SpookerApp(),
  ));
}

class SpookerApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: SpookerStrings.spookerAppName,
        home: CreateAccountScreen(),
        routes: {
          SpookerRoutes.pageHome: (context) => LoginScreen(),
          SpookerRoutes.pageSignUp: (context) => CreateAccountScreen(),
        });
  }
}
