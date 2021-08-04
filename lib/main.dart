import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/manager/manager_home_container/manager_home_container.dart';
import 'package:fastcheque/screens/staff/staff_home_container/staff_home_container.dart';
import 'package:fastcheque/service/authentication_service.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/database_constants.dart';
import 'package:fastcheque/utils/navigator.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late String? CURRENT_USER_TYPE = null;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  CURRENT_USER_TYPE = prefs.getString(PreferenceKey.USER_TYPE);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthenticationService(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FireStoreService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FastCheque',
        theme: globalTheme(context),
        onGenerateRoute: NavRoute.generatedRoute,
        // initialRoute: Login.LOGIN_ROUTE,
        home: (CURRENT_USER_TYPE == null)
            ? Login()
            : (CURRENT_USER_TYPE == DatabaseConstants.USERS_TYPE_MANAGER)
                ? ManagerHomeContainer()
                : StaffHomeContainer(),
      ),
    );
  }
}
