import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  static const String FORGET_PASSWORD_ROUTE = '/forget_password';
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(title: 'Forget Password'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(defaultPadding),
                children: [
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
                      onPressed: () => null,
                      child: Text('Send Pasword Reset Link'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
