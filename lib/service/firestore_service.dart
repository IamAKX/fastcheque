import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque/model/store_model.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/database_constants.dart';

class FireStoreService {
  static FireStoreService instance = FireStoreService();
  late FirebaseFirestore _firestore;
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
}
