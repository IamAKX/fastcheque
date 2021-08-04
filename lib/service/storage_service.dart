import 'dart:io';

import 'package:fastcheque/service/snakbar_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class StorageService {
  static StorageService instance = StorageService();
  late FirebaseStorage _firebaseStorage;

  StorageService() {
    _firebaseStorage = FirebaseStorage.instance;
  }

  Future<String> uploadCheque(File file, BuildContext context) async {
    //Create a reference to the location you want to upload to in firebase
    ProgressDialog pd = ProgressDialog(context: context);
    try {
      pd.show(
        max: 100,
        progressType: ProgressType.normal,
        msg: 'File Uploading...',
        progressBgColor: Colors.transparent,
      );
      Reference reference = _firebaseStorage
          .ref()
          .child("CHEQUE/${file.path.substring(file.path.lastIndexOf('/'))}");

      //Upload the file to firebase
      UploadTask uploadTask = reference.putFile(file);
      var dowurl = await (await uploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();
      pd.close();
      SnackBarService.instance.showSnackBarSuccess('Upload Successful');
      return dowurl.toString();
    } catch (e) {
      pd.close();
      SnackBarService.instance.showSnackBarError('Upload failed');
      return "";
    }
  }
}
