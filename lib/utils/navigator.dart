import 'package:fastcheque/screens/common/change_password/change_password.dart';
import 'package:fastcheque/screens/common/forget_password/forget_password.dart';
import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/screens/common/register/register_screen.dart';
import 'package:fastcheque/screens/common/upload_signature/upload_signature.dart';
import 'package:fastcheque/screens/manager/cheque_details_manager_view/cheque_details_manager_view.dart';
import 'package:fastcheque/screens/manager/manager_home_container/manager_home_container.dart';
import 'package:fastcheque/screens/manager/staff_detail_view/staff_detail_view.dart';
import 'package:fastcheque/screens/staff/cheque_details_staff_view/cheque_details_staff_view.dart';
import 'package:fastcheque/screens/staff/staff_home_container/staff_home_container.dart';
import 'package:flutter/material.dart';

class NavRoute {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case Login.LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => Login());
      case Register.REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) => Register());
      case ForgetPassword.FORGET_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => ForgetPassword());
      case StaffHomeContainer.STAFF_HOME_CONTAINER_ROUTE:
        return MaterialPageRoute(builder: (_) => StaffHomeContainer());
      case UploadSignature.UPLOAD_SIGNATURE_ROUTE:
        return MaterialPageRoute(builder: (_) => UploadSignature());
      case ChangePassword.CHANGE_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case ManagerHomeContainer.MANAGER_HOME_CONTAINER_ROUTE:
        return MaterialPageRoute(builder: (_) => ManagerHomeContainer());
      case ChequeDetailsStaffView.CHEQUE_DETAILS_STAFF_VIEW:
        return MaterialPageRoute(builder: (_) => ChequeDetailsStaffView());
      case ChequeDetailsManagerView.CHEQUE_DETAILS_MANAGER_VIEW:
        return MaterialPageRoute(builder: (_) => ChequeDetailsManagerView());
      case StaffDetailView.STAFF_DETAIL_VIEW:
        return MaterialPageRoute(builder: (_) => StaffDetailView());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Undefined route'),
        ),
      );
    });
  }
}
