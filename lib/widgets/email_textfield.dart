import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required TextEditingController emailCtrl,
  })  : _emailCtrl = emailCtrl,
        super(key: key);

  final TextEditingController _emailCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: true,
        controller: _emailCtrl,
        decoration: InputDecoration(
          hintText: 'Email',
          labelText: 'Email',
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }
}
