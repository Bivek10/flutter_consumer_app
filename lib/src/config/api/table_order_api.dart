import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_secrets.skeleton.dart';
import '../../core/utils/snack_bar.dart';
import '../firebase/auth.dart';
import '../routes/routesname.dart';

class TableOrderApi {
  void addToCart({
    required String productname,
    required Map<String, dynamic> data,
  }) async {
    String repeatedid =
        await isAlreadyAdded(data["userid"], data["productuid"]);
    if (repeatedid != "") {
      //sprint(repeatedid);
      data["quantity"] = (int.parse(data["quantity"]) + 1).toString();
      data["subtotal"] =
          (int.parse(data["quantity"]) * int.parse(data["price"]));
      print(data);
      await firebaseFirestore
          .collection(AppSecrets.consumercart)
          .doc(repeatedid)
          .set(data)
          .then((value) {
        showSuccess(message: "$productname updated in cart");
      });
    } else {
      firebaseFirestore
          .collection(AppSecrets.consumercart)
          .add(data)
          .then((value) {
        showSuccess(message: "$productname added in cart");
      });
    }
  }

  Future<String> isAlreadyAdded(String userid, String productuid) async {
    String isDouble = "";
    String isChecked = await firebaseFirestore
        .collection(AppSecrets.consumercart)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()["productuid"] == productuid &&
              element.data()["userid"] == userid &&
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

  Stream<QuerySnapshot> getcartByUserid() {
    return firebaseFirestore.collection(AppSecrets.consumercart).snapshots();
  }

  Future<void> incrementQuantity(
      {required String productname,
      required Map<String, dynamic> data,
      required cartuid}) async {
    data.remove("fooduid");

    data["quantity"] = (int.parse(data["quantity"]) + 1).toString();
    data["subtotal"] = (int.parse(data["quantity"]) * int.parse(data["price"]));

    await firebaseFirestore
        .collection(AppSecrets.consumercart)
        .doc(cartuid)
        .set(data)
        .then((value) {
      showSuccess(message: "$productname updated in cart");
    });
  }

  Future<void> decrementQuantity(
      {required String productname,
      required Map<String, dynamic> data,
      required cartuid}) async {
    if (int.parse(data["quantity"]) > 1) {
      data.remove("cartuid");
      data["quantity"] = (int.parse(data["quantity"]) - 1).toString();
      data["subtotal"] =
          (int.parse(data["quantity"]) * int.parse(data["price"]));
      // print(data);
      await firebaseFirestore
          .collection(AppSecrets.consumercart)
          .doc(cartuid)
          .set(data)
          .then((value) {
        showSuccess(message: "$productname updated in cart");
      });
    } else {
      await firebaseFirestore
          .collection(AppSecrets.consumercart)
          .doc(cartuid)
          .delete()
          .then((value) {
        showSuccess(message: "$productname is deleted.");
      });
    }
  }

  updateOrderStatus(
      {required Map<String, dynamic> data,
      required BuildContext context}) async {
    firebaseFirestore
        .collection(AppSecrets.consumerorder)
        .add(data)
        .then((value) async {
      for (int val = 0; val < data["orderData"].length; val++) {
        firebaseFirestore
            .collection(AppSecrets.consumercart)
            .doc(data["orderData"][val]["cartuid"])
            .delete();
      }
      showSuccess(message: "Order has placed sucessfully");

      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.mainPage, (route) => false);
    });
  }
}
