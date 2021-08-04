import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/model/store_model.dart';
import 'package:fastcheque/screens/common/change_password/change_password.dart';
import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/common/upload_signature/upload_signature.dart';
import 'package:fastcheque/service/authentication_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:fastcheque/widgets/error_information.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class StaffProfile extends StatefulWidget {
  const StaffProfile({Key? key}) : super(key: key);

  @override
  _StaffProfileState createState() => _StaffProfileState();
}

class _StaffProfileState extends State<StaffProfile> {
  late StaffModel _staffModel;
  late StoreModel _currentStore;

  loadStaffFromCache() {
    setState(() {
      _staffModel =
          StaffModel.fromJson(prefs.getString(PreferenceKey.USER_DATA)!);
      _currentStore =
          StoreModel.fromJson(prefs.getString(PreferenceKey.CURRENT_STORE)!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStaffFromCache();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(defaultPadding * 2),
      children: [
        Text(
          'Hi, ${_staffModel.name}!',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: primaryColor,
              ),
        ),
        Text(
          '${_currentStore.businessName}',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: primaryColor,
              ),
        ),
        Text(
          '${_currentStore.businessAddress}',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: primaryColor,
              ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        ErrorInformation(
          hint: getErrorList(),
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

  getErrorList() {
    List<String> err = [];

    if (_staffModel.signatureUrl.isEmpty) err.add('Upload you signature');
    if (_staffModel.isPasswordTemporary)
      err.add(
        'Reset your password',
      );

    return err;
  }
}
