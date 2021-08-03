import 'package:dropdown_search/dropdown_search.dart';
import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/model/store_model.dart';
import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/service/authentication_service.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/database_constants.dart';
import 'package:fastcheque/utils/validation.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:fastcheque/widgets/email_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:fastcheque/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static const String REGISTER_ROUTE = '/register';
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
  List<StoreModel> _storeList = [];
  late StoreModel _selectedStore;
  late AuthenticationService _auth;

  _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStore();
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthenticationService>(context);

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
                    items: _storeList
                        .map((store) =>
                            '${store.businessName} (${store.chequeSequenceNumber})')
                        .toList(),
                    label: "Store",
                    hint: "Store",
                    searchBoxController: _storeCtrl,
                    dropDownButton: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF878787),
                      size: 30,
                    ),
                    onChanged: (value) {
                      if (_storeList.isNotEmpty) {
                        for (StoreModel store in _storeList) {
                          if (value ==
                              '${store.businessName} (${store.chequeSequenceNumber})') {
                            setState(() {
                              _selectedStore = store;
                            });
                            return;
                          }
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  TextButton(
                    child: Text(
                      _auth.status == AuthStatus.Authenticating
                          ? 'Please wait...'
                          : 'Register',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: Colors.white),
                    ),
                    onPressed: _auth.status == AuthStatus.Authenticating
                        ? null
                        : () {
                            if (checkAllEmptyString(
                                  [
                                    _nameCtrl.text,
                                    _emailCtrl.text,
                                    _passwordCtrl.text,
                                    _selectedStore.chequeSequenceNumber
                                  ],
                                ) &&
                                checkValidEmail(_emailCtrl.text)) {
                              if (_selectedStore == null) {
                                SnackBarService.instance
                                    .showSnackBarError('Select store');
                                return;
                              }
                              StaffModel staff = StaffModel(
                                  id: '',
                                  uid: '',
                                  name: _nameCtrl.text,
                                  email: _emailCtrl.text,
                                  signatureUrl: '',
                                  isProfileActive: false,
                                  isPasswordTemporary: false,
                                  hasManagerApproved: false,
                                  firebaseFCMToken: '',
                                  userType: DatabaseConstants.USERS_TYPE_STAFF,
                                  taggedStore: _selectedStore);
                              _auth.registerUserWithEmailAndPassword(
                                  staff, _passwordCtrl.text, context);
                            }
                          },
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
                          onTap: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  Login.LOGIN_ROUTE, (route) => false),
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

  Future<void> loadStore() async {
    FireStoreService.instance.readAllStore().then((list) {
      setState(() {
        _storeList.addAll(list);
      });
    });
  }
}
