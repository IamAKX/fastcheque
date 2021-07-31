import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/error_information.dart';
import 'package:flutter/material.dart';

class StaffProfile extends StatefulWidget {
  const StaffProfile({Key? key}) : super(key: key);

  @override
  _StaffProfileState createState() => _StaffProfileState();
}

class _StaffProfileState extends State<StaffProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(defaultPadding * 2),
      children: [
        Text(
          'Hi, Name!',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 50,
                color: primaryColor,
              ),
        ),
        Text(
          'Store name,',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: primaryColor,
              ),
        ),
        Text(
          'Address line 1',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: primaryColor,
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
          onTap: () => null,
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
          onTap: () => null,
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
          onTap: () => null,
        )
      ],
    );
  }
}
