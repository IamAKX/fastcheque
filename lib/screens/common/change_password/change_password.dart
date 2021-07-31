import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:fastcheque/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  static const String CHANGE_PASSWORD_ROUTE = '/changePassword';
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmNewPassword = TextEditingController();

  bool _isNewPasswordHidded = true;
  bool _isConfirmNewPasswordHidded = true;

  _toggleNewPasswordVisibility() {
    setState(() {
      _isNewPasswordHidded = !_isNewPasswordHidded;
    });
  }

  _toggleConfirmNewPasswordVisibility() {
    setState(() {
      _isConfirmNewPasswordHidded = !_isConfirmNewPasswordHidded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgColor,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: hintColor.withOpacity(0.5),
        ),
        title: Heading(
          title: 'Password',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              PasswordTextField(
                passwordCtrl: _newPassword,
                isPasswordVisible: _isNewPasswordHidded,
                tooglePasswordVisibility: _toggleNewPasswordVisibility,
                hint: 'New Password',
              ),
              PasswordTextField(
                passwordCtrl: _confirmNewPassword,
                isPasswordVisible: _isConfirmNewPasswordHidded,
                tooglePasswordVisibility: _toggleConfirmNewPasswordVisibility,
                hint: 'Confrim Password',
              ),
              Text(
                'You will be logged out after changing the password. Login again with new password.',
                style: Theme.of(context).textTheme.caption,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => null,
                  child: Text('Change Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
