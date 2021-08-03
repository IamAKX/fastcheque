import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque/main.dart';
import 'package:fastcheque/model/manager_model.dart';
import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/screens/manager/manager_home_container/manager_home_container.dart';
import 'package:fastcheque/screens/staff/staff_home_container/staff_home_container.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/database_constants.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  static AuthenticationService instance = AuthenticationService();
  late FirebaseAuth _auth;

  AuthenticationService() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> registerUserWithEmailAndPassword(
      FirebaseFirestore firestore, ManagerModel model) async {
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: model.email, password: model.email);
      User? user = _result.user;

      user!.updateDisplayName(model.name);
      user.sendEmailVerification();

      DocumentReference document =
          firestore.collection(DatabaseConstants.USERS_COLLECTION).doc();
      model.id = document.id;
      model.uid = user.uid;

      await document.set(model.toMap()).then((value) {
        // showToast('User created successfully');
        SnackBarService.instance
            .showSnackBarSuccess('User created successfully');
        return;
      });
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError('${e.message}');
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String _email, String _password, BuildContext context) async {
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      User? user = _result.user;

      if (!user!.emailVerified) {
        SnackBarService.instance.showSnackBarError('Email not verified');
        this.logoutUser();
      } else {
        await FirebaseFirestore.instance
            .collection(DatabaseConstants.USERS_COLLECTION)
            .where('uid', isEqualTo: user.uid)
            .get()
            .then((value) {
          QueryDocumentSnapshot firstRes = value.docs.first;
          Map<String, dynamic> map = firstRes.data() as Map<String, dynamic>;

          if (map['userType'] == DatabaseConstants.USERS_TYPE_MANAGER) {
            ManagerModel userData = ManagerModel.fromMap(map);
            if (!userData.isProfileActive) {
              SnackBarService.instance.showSnackBarError(
                  'Profile is deactivated by Admin. Contact Admin.');
              this.logoutUser();
              return;
            }
            SnackBarService.instance
                .showSnackBarSuccess('Authentication successful!');
            prefs.setString(PreferenceKey.USER_DATA, userData.toJson());
            prefs.setString(PreferenceKey.USER_TYPE, userData.userType);
            Navigator.of(context).pushNamedAndRemoveUntil(
                ManagerHomeContainer.MANAGER_HOME_CONTAINER_ROUTE,
                (route) => false);
          } else {
            StaffModel userData = StaffModel.fromMap(map);
            if (!userData.isProfileActive) {
              SnackBarService.instance.showSnackBarError(
                  'Profile is deactivated by Admin. Contact Admin.');
              this.logoutUser();
              return;
            }
            if (!userData.hasManagerApproved) {
              SnackBarService.instance.showSnackBarError(
                  'Profile is deactivated by Manager. Contact Store manager.');
              this.logoutUser();
              return;
            }
            SnackBarService.instance
                .showSnackBarSuccess('Authentication successful!');
            prefs.setString(PreferenceKey.USER_DATA, userData.toJson());
            prefs.setString(PreferenceKey.USER_TYPE, userData.userType);
            Navigator.of(context).pushNamedAndRemoveUntil(
                StaffHomeContainer.STAFF_HOME_CONTAINER_ROUTE,
                (route) => false);
          }
        }).catchError(
                // ignore: invalid_return_type_for_catch_error
                (e) => SnackBarService.instance.showSnackBarError(e.message!));
      }
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
    }
  }

  void logoutUser() async {
    try {
      await _auth.signOut();
      prefs.clear();
      return;
    } catch (e) {
      SnackBarService.instance.showSnackBarError("Error Logging Out");
    }
  }
}
