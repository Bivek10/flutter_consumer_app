import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/utils/app_secrets.skeleton.dart';
import '../../core/utils/snack_bar.dart';
import '../firebase/auth.dart';

class TableOrderApi {
  void addToCart({
    required String productname,
    required Map<String, dynamic> data,
  }) async {
    String repeatedid =
        await isAlreadyAdded(data["tableuid"], data["productuid"]);
    if (repeatedid != "") {
      //sprint(repeatedid);
      data["quantity"] = (int.parse(data["quantity"]) + 1).toString();
      data["subtotal"] =
          (int.parse(data["quantity"]) * int.parse(data["price"]));
      // print(data);
      await firebaseFirestore
          .collection(AppSecrets.tableorder)
          .doc(repeatedid)
          .set(data)
          .then((value) {
        showSuccess(message: "$productname updated in cart");
      });
    } else {
      firebaseFirestore
          .collection(AppSecrets.tableorder)
          .add(data)
          .then((value) {
        showSuccess(message: "$productname added in cart");
      });
    }
  }

  Future<String> isAlreadyAdded(String tableid, String productuid) async {
    String isDouble = "";
    String isChecked = await firebaseFirestore
        .collection(AppSecrets.tableorder)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()["productuid"] == productuid &&
              element.data()["tableuid"] == tableid &&
              element.data()["isorder"] == true) {
            isDouble = element.id;
          }
        }
      } else {
        isDouble = "";
      }
      return isDouble;
    });
    return isChecked;
  }

  Stream<QuerySnapshot> getcartByTableid({required String tableid}) {
    return firebaseFirestore.collection(AppSecrets.tableorder).snapshots();
  }

  Future<void> incrementQuantity(
      {required String productname,
      required Map<String, dynamic> data,
      required fooduid}) async {
    data.remove("fooduid");

    data["quantity"] = (int.parse(data["quantity"]) + 1).toString();
    data["subtotal"] = (int.parse(data["quantity"]) * int.parse(data["price"]));

    await firebaseFirestore
        .collection(AppSecrets.tableorder)
        .doc(fooduid)
        .set(data)
        .then((value) {
      showSuccess(message: "$productname updated in cart");
    });
  }

  Future<void> decrementQuantity(
      {required String productname,
      required Map<String, dynamic> data,
      required fooduid}) async {
    if (int.parse(data["quantity"]) > 1) {
      data.remove("fooduid");
      data["quantity"] = (int.parse(data["quantity"]) - 1).toString();
      data["subtotal"] =
          (int.parse(data["quantity"]) * int.parse(data["price"]));
      // print(data);
      await firebaseFirestore
          .collection(AppSecrets.tableorder)
          .doc(fooduid)
          .set(data)
          .then((value) {
        showSuccess(message: "$productname updated in cart");
      });
    } else {
      await firebaseFirestore
          .collection(AppSecrets.tableorder)
          .doc(fooduid)
          .delete()
          .then((value) {
        showSuccess(message: "$productname is deleted.");
      });
    }
  }
}
