import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/common/register/register_screen.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastCheque',
      theme: globalTheme(context),
      onGenerateRoute: NavRoute.generatedRoute,
      initialRoute: Login.LOGIN_ROUTE,
      home: Login(),
    );
  }
}
