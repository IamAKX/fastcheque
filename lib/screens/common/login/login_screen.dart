import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

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
                  EmailTextField(emailCtrl: _emailCtrl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
