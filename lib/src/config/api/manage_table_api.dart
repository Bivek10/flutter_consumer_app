import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_skeleton/src/config/firebase/auth.dart';

import '../../core/utils/app_mixin.dart';
import '../../core/utils/app_secrets.skeleton.dart';
import '../../core/utils/snack_bar.dart';
import '../routes/routesname.dart';

class ManageTableApi with ConnectivityMixin {
  void addTable({
    required Map<String, dynamic> cred,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    try {
      if (await isAlreadyAdded(cred["tableid"])) {
        isSuccess.value = false;
        showError(message: "Table with this ID is already exist");
      } else {
        firebaseFirestore
            .collection(AppSecrets.tablecollection)
            .add(cred)
            .then((value) {
          isSuccess.value = false;
          formKey.currentState!.reset();
          showSuccess(
            message: "Table added successfully",
          );
        });
      }
    } on FirebaseException catch (e) {
      isSuccess.value = false;
      showError(message: e.toString());
    }
  }

  Future<bool> isAlreadyAdded(final String tableid) async {
    bool isDouble = false;
    bool isChecked = await firebaseFirestore
        .collection(AppSecrets.tablecollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()["tableid"] == tableid) {
            isDouble = true;
          }
        }
      } else {
        isDouble = false;
      }
      return isDouble;
    });
    return isChecked;
  }

  Stream<QuerySnapshot<Object?>> getTableInfo() {
    return firebaseFirestore.collection(AppSecrets.tablecollection).snapshots();
  }

  deleteTable(String tableUid) {
    firebaseFirestore
        .collection(AppSecrets.tablecollection)
        .doc(tableUid)
        .delete()
        .then((value) {
      showSuccess(message: "Table has removed");
    });
  }

  editTable(
      {required Map<String, dynamic> data,
      required ValueNotifier<bool> isSuccess,
      required GlobalKey<FormBuilderState> formKey,
      required String tableUid}) async {
    await firebaseFirestore
        .collection(AppSecrets.tablecollection)
        .doc(tableUid)
        .set(data)
        .then((value) {
      isSuccess.value = false;
      showSuccess(message: "Table update successfully!");
    }).onError((error, stackTrace) {
      isSuccess.value = false;
      showError(message: error.toString());
    });
  }

  // updateTableStatus(
  //     {required String totalbill,
  //     required String userid,
  //     required BuildContext context}) async {
  //   await firebaseFirestore
  //       .collection(AppSecrets.tablecollection)
  //       .doc(tableUid)
  //       .update({"isRunning": true, "totalbill": totalbill}).then((value) {
  //     showSuccess(message: "Order has placed");
      // Navigator.pushNamedAndRemoveUntil(
      //     context, RouteName.mainPage, (route) => false);
  //   }).onError((error, stackTrace) {
  //     showError(message: error.toString());
  //   });
  // }

  onCompleteOrder(
      {required tableuid,
      required Map<String, dynamic> tabledata,
      required String totalbill,
      required BuildContext context}) async {
    List<String> ordertableIDList = [];
    await firebaseFirestore
        .collection(AppSecrets.tableorder)
        .get()
        .then((value) async {
      for (var e in value.docs) {
        if (e["tableuid"] == tableuid) {
          await firebaseFirestore
              .collection(AppSecrets.tableorder)
              .doc(e.id)
              .update(
            {"isorder": false},
          );
          ordertableIDList.add(e.id);
        }
      }
    });
    await firebaseFirestore
        .collection(AppSecrets.tablecollection)
        .doc(tableuid)
        .set(tabledata)
        .then((value) async {
      DateTime datetime = DateTime.now();
      await firebaseFirestore.collection("payment").add({
        "datetime": datetime.toString(),
        "tableid": tableuid,
        "paid amount": totalbill,
        "ordertableids": ordertableIDList,
      }).then((value) {
        Navigator.pop(context);
        showSuccess(message: "Order of table is compeleted");
      });
    });
  }

  onCancleOrder(
      {required tableuid,
      required Map<String, dynamic> tabledata,
      required BuildContext context}) async {
    await firebaseFirestore
        .collection(AppSecrets.tableorder)
        .get()
        .then((value) async {
      for (var e in value.docs) {
        if (e["tableuid"] == tableuid) {
          await firebaseFirestore
              .collection(AppSecrets.tableorder)
              .doc(e.id)
              .update(
            {"isorder": false},
          );
        }
      }
      await firebaseFirestore
          .collection(AppSecrets.tablecollection)
          .doc(tableuid)
          .set(tabledata)
          .then((value) async {
        showSuccess(message: "Order cancled");
      });
    });
  }
}
