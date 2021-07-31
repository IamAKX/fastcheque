import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:fastcheque/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  bool _isPasswordHidden = true;

  _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      onTap: () => null,
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
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: primaryColor),
                    ),
                    onPressed: () => null,
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
                          onTap: () => null,
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
