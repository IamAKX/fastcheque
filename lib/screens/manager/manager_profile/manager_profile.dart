import 'package:fastcheque/screens/common/change_password/change_password.dart';
import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/common/upload_signature/upload_signature.dart';
import 'package:fastcheque/service/authentication_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/error_information.dart';
import 'package:flutter/material.dart';

class ManagerProfile extends StatefulWidget {
  const ManagerProfile({Key? key}) : super(key: key);

  @override
  _ManagerProfileState createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(defaultPadding * 2),
      children: [
        Text(
          'Hi, Name!',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: primaryColor,
              ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: primaryColor,
            ),
          ),
          title: Text(
            'Store name,',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: primaryColor,
                ),
          ),
          subtitle: Text(
            'Address line 1',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: primaryColor,
                ),
          ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        ErrorInformation(
          hint: [
            'Upload you signature',
            'Reset your password',
          ],
        ),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headline6,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Upload signature'),
          leading: Icon(Icons.edit_outlined),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () => Navigator.of(context)
              .pushNamed(UploadSignature.UPLOAD_SIGNATURE_ROUTE),
        ),
        Divider(
          color: hintColor,
          indent: 50,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Change password'),
          leading: Icon(Icons.lock_outline),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () => Navigator.of(context)
              .pushNamed(ChangePassword.CHANGE_PASSWORD_ROUTE),
        ),
        Divider(
          color: hintColor,
          indent: 50,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Sign out'),
          leading: Icon(Icons.logout),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () {
            AuthenticationService.instance.logoutUser();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Login.LOGIN_ROUTE, (route) => false);
          },
        )
      ],
    );
  }
}
