import 'package:fastcheque/screens/common/forget_password/forget_password.dart';
import 'package:fastcheque/screens/common/register/register_screen.dart';
import 'package:fastcheque/service/authentication_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:fastcheque/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String LOGIN_ROUTE = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  bool _isPasswordHidden = true;
  late AuthenticationService _auth;
  _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(title: 'Login'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(defaultPadding),
                children: [
                  EmailTextField(emailCtrl: _emailCtrl),
                  PasswordTextField(
                    passwordCtrl: _passwordCtrl,
                    isPasswordVisible: _isPasswordHidden,
                    tooglePasswordVisibility: _togglePasswordVisibility,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(ForgetPassword.FORGET_PASSWORD_ROUTE),
                      child: Container(
                        margin: EdgeInsets.only(bottom: defaultPadding),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  OutlinedButton(
                    child: Text(
                      _auth.status == AuthStatus.Authenticating
                          ? 'Please wait...'
                          : 'Login',
                    ),
                    onPressed: () => _auth.status == AuthStatus.Authenticating
                        ? null
                        : _auth.loginUserWithEmailAndPassword(
                            _emailCtrl.text, _passwordCtrl.text, context),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Are you a new staff member? ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: hintColor),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  Register.REGISTER_ROUTE, (route) => false),
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
