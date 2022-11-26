import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../core/utils/app_secrets.skeleton.dart';
import '../../core/utils/snack_bar.dart';
import '../firebase/auth.dart';

class ManageStaffAPI {
  Stream<QuerySnapshot<Object?>> getStaffInfo() {
    return firebaseFirestore.collection(AppSecrets.staffcollection).snapshots();
  }

  deleteStaffTable(String staffUid, BuildContext context) async {
    await firebaseFirestore
        .collection(AppSecrets.staffcollection)
        .doc(staffUid)
        .delete()
        .then((value) {
      showSuccess(message: "Staff Deleted");
    });
  }

  Future<bool> updateStaff(
      {required Map<String, dynamic> data,
      required bool isRole,
      required String staffuid}) async {
    bool status = false;
    await firebaseFirestore
        .collection(AppSecrets.staffcollection)
        .doc(staffuid)
        .set(data)
        .then((value) {
      if (isRole) {
        showSuccess(message: "Role has updated successfully");
      } else {
        if (data["isVerify"]) {
          showSuccess(message: "Account Activated.");
        } else {
          showSuccess(message: "Account Deactivated.");
        }
      }
      status = true;
    }).onError((error, stackTrace) {
      status = false;
      showError(message: error.toString());
    });
    return status;
  }
}
