import 'package:fastcheque/screens/common/forget_password/forget_password.dart';
import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/common/register/register_screen.dart';
import 'package:flutter/material.dart';

class NavRoute {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case Login.LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => Login());
      case Register.REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) => Register());
      case ForgetPassword.FORGET_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => ForgetPassword());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Undefined route'),
        ),
      );
    });
  }
}
