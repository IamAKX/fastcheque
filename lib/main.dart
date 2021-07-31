import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/common/register/register_screen.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/navigator.dart';
import 'package:flutter/material.dart';

void main() {
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
