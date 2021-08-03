import 'package:fastcheque/service/authentication_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/validation.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  static const String FORGET_PASSWORD_ROUTE = '/forget_password';
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailCtrl = TextEditingController();
  late AuthenticationService _auth;

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(defaultPadding),
                children: [
                  Heading(title: 'Forgot Password'),
                  Text(
                    'Enter your registed email address. Password reset link will be shared on your email.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  EmailTextField(emailCtrl: _emailCtrl),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  OutlinedButton(
                      onPressed: _auth.status == AuthStatus.Authenticating
                          ? null
                          : () {
                              if (checkValidEmail(_emailCtrl.text)) {
                                _auth.forgotPassword(_emailCtrl.text);
                              }
                            },
                      child: Text(_auth.status == AuthStatus.Authenticating
                          ? 'Please wait...'
                          : 'Send Pasword Reset Link'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
