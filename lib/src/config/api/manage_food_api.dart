import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_skeleton/src/providers/image_file_provider.dart';
import 'package:provider/provider.dart';
import '../firebase/auth.dart';
import '../../core/utils/snack_bar.dart';

import '../../core/utils/app_mixin.dart';
import '../../core/utils/app_secrets.skeleton.dart';

class ManageFoodApi with ConnectivityMixin {
  void addCategory({
    required Map<String, dynamic> cred,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    try {
      if (await isAlreadyAdded(cred["categoryid"])) {
        isSuccess.value = false;
        showError(message: "Category with this ID is already exist");
      } else {
        firebaseFirestore
            .collection(AppSecrets.categorycollection)
            .add(cred)
            .then((value) {
          isSuccess.value = false;
          formKey.currentState!.reset();
          showSuccess(
            message: "Category added successfully",
          );
        });
      }
    } on FirebaseException catch (e) {
      isSuccess.value = false;
      showError(message: e.toString());
    }
  }

  Future<bool> isAlreadyAdded(final String cateid) async {
    bool isDouble = false;
    bool isChecked = await firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()["categoryid"] == cateid) {
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

  Stream<QuerySnapshot<Object?>> getCategoryInfo() {
    return firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getCategoryFuture() async {
    List<Map<String, dynamic>> data = [];
    await firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .get()
        .then((value) {
      for (var ele in value.docs) {
        Map<String, dynamic> category = {"uid": ele.id};
        category.addAll(ele.data());
        data.add(category);
      }
    });
    return data;
  }

  Future<List<Map<String, dynamic>>> getCategoryByMenu(
      String categoryID) async {
    List<Map<String, dynamic>> data = [];
    await firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .doc(categoryID)
        .collection(AppSecrets.foodmenu)
        .get()
        .then((value) {
      for (var i in value.docs) {
        Map<String, dynamic> product = {"uid": i.id};
        product.addAll(i.data());
        data.add(product);
      }
    });
    return data;
  }

  deleteCategory(String tableUid) {
    firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .doc(tableUid)
        .delete()
        .then((value) {
      showSuccess(message: "Category has removed");
    });
  }

  editCategory(
      {required Map<String, dynamic> data,
      required ValueNotifier<bool> isSuccess,
      required GlobalKey<FormBuilderState> formKey,
      required String cateUid}) async {
    await firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .doc(cateUid)
        .set(data)
        .then((value) {
      isSuccess.value = false;
      showSuccess(message: "Category update successfully!");
    }).onError((error, stackTrace) {
      isSuccess.value = false;
      showError(message: error.toString());
    });
  }

  void addFoodMenu({
    required String catID,
    required Map<String, dynamic> cred,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
    required BuildContext context,
  }) async {
    try {
      firebaseFirestore
          .collection(AppSecrets.categorycollection)
          .doc(catID)
          .collection(AppSecrets.foodmenu)
          .add(cred)
          .whenComplete(() => null)
          .then((value) {
        isSuccess.value = false;
        formKey.currentState!.reset();
        Provider.of<ImageFileReciver>(context, listen: false)
            .receivedImagePath(null);
        showSuccess(
          message: "Menu item added successfully",
        );
      });
    } on FirebaseException catch (e) {
      isSuccess.value = false;
      showError(message: e.toString());
    }
  }

  Future<String> getDownloadURL(String fileName) async {
    try {
      return await firebaseStorage.ref().child(fileName).getDownloadURL();
    } catch (e) {
      return "";
    }
  }

  Stream<QuerySnapshot> getFoodByCatID(String categoryID) {
    return firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .doc(categoryID)
        .collection(AppSecrets.foodmenu)
        .snapshots();
  }

  updateFoodMenu({
    required Map<String, dynamic> data,
    required ValueNotifier<bool> isSuccess,
    required GlobalKey<FormBuilderState> formKey,
    required String cateUid,
    required String fooduid,
    required BuildContext context,
  }) async {
    await firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .doc(cateUid)
        .collection(AppSecrets.foodmenu)
        .doc(fooduid)
        .set(data)
        .then((value) {
      isSuccess.value = false;
      showSuccess(message: "Item update successfully!");

      Provider.of<ImageFileReciver>(context, listen: false)
          .receivedImagePath(null);
    }).onError((error, stackTrace) {
      isSuccess.value = false;
      showError(message: error.toString());
    });
  }

  deleteFoodItem(
      {required String categoryID,
      required String fooduid,
      required BuildContext context}) {
    firebaseFirestore
        .collection(AppSecrets.categorycollection)
        .doc(categoryID)
        .collection(AppSecrets.foodmenu)
        .doc(fooduid)
        .delete()
        .then((value) {
      showSuccess(message: "Item removed successfully");
      Navigator.pop(context);
    });
  }
}
