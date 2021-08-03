import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  static FireStoreService instance = FireStoreService();
  late FirebaseFirestore _firestore;
  FireStoreService() {
    _firestore = FirebaseFirestore.instance;
  }
}
