import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/model/store_model.dart';
import 'package:fastcheque/model/transaction_model.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/database_constants.dart';
import 'package:flutter/material.dart';

enum DatabaseTransactionStatus { IDEAL, QUERYING, SUCCESS, FAILED }

class FireStoreService extends ChangeNotifier {
  static FireStoreService instance = FireStoreService();
  late FirebaseFirestore _firestore;
  DatabaseTransactionStatus? status = DatabaseTransactionStatus.IDEAL;

  FireStoreService() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<List<StoreModel>> readAllStore() async {
    List<StoreModel> list = [];

    await _firestore
        .collection(DatabaseConstants.STORE_COLLECTION)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((querySnapshot) {
        StoreModel store = StoreModel.fromMap(querySnapshot.data());
        list.add(store);
      });
      return list;
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => SnackBarService.instance.showSnackBarError(error));
    return list;
  }

  Future<List<StaffModel>> readAllStaff() async {
    List<StaffModel> list = [];
    status = DatabaseTransactionStatus.QUERYING;
    notifyListeners();
    await _firestore
        .collection(DatabaseConstants.USERS_COLLECTION)
        .where('userType', isEqualTo: DatabaseConstants.USERS_TYPE_STAFF)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((querySnapshot) {
        StaffModel store = StaffModel.fromMap(querySnapshot.data());
        list.add(store);
      });
      status = DatabaseTransactionStatus.SUCCESS;
      notifyListeners();
      return list;
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) {
      status = DatabaseTransactionStatus.FAILED;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(error);
    });
    status = DatabaseTransactionStatus.SUCCESS;
    notifyListeners();
    return list;
  }

  Future<bool> toggleManagerApprovedStatus(StaffModel staff) async {
    await _firestore
        .collection(DatabaseConstants.USERS_COLLECTION)
        .doc(staff.id)
        .update({'hasManagerApproved': staff.hasManagerApproved}).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
    return false;
  }

  Future<int> getChequeCountStartingWith(String sequencePrefix) async {
    int count = 0;
    await _firestore
        .collection(DatabaseConstants.TRANSACTION_COLLECTION)
        .where('chequeSequence', isEqualTo: sequencePrefix)
        .get()
        .then((value) {
      count = value.docs.length;
    }).onError((error, stackTrace) {
      SnackBarService.instance.showSnackBarError(error.toString());
    });
    return count;
  }

  Future<bool> createTransaction(TransactionModel model) async {
    status = DatabaseTransactionStatus.QUERYING;
    notifyListeners();
    DocumentReference ref =
        _firestore.collection(DatabaseConstants.TRANSACTION_COLLECTION).doc();
    model.id = ref.id;
    await ref.set(model.toMap()).then((value) {
      status = DatabaseTransactionStatus.SUCCESS;
      notifyListeners();
      SnackBarService.instance.showSnackBarSuccess('Cheque sent for approval');
      return true;
    }).catchError((err) {
      status = DatabaseTransactionStatus.FAILED;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(err.toString());
      return false;
    });
    status = DatabaseTransactionStatus.FAILED;
    notifyListeners();
    return false;
  }
}
