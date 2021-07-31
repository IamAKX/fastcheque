import 'package:dropdown_search/dropdown_search.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:fastcheque/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _storeCtrl = TextEditingController();
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
            Heading(title: 'Register'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(defaultPadding),
                children: [
                  CustomTextField(
                    textCtrl: _nameCtrl,
                    hint: 'Name',
                    iconData: Icons.person,
                  ),
                  EmailTextField(emailCtrl: _emailCtrl),
                  PasswordTextField(
                    passwordCtrl: _passwordCtrl,
                    isPasswordVisible: _isPasswordHidden,
                    tooglePasswordVisibility: _togglePasswordVisibility,
                  ),
                  DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: ["Store 1", "Store 2", "Store 3", 'Store 4'],
                    label: "Store",
                    hint: "Store",
                    searchBoxController: _storeCtrl,
                    dropDownButton: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF878787),
                      size: 30,
                    ),
                    onChanged: print,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  TextButton(
                    child: Text(
                      'Register',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.white),
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
                          'Already have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: hintColor),
                        ),
                        InkWell(
                          onTap: () => null,
                          child: Text(
                            'Login',
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
