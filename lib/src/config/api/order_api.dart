import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/utils/app_secrets.skeleton.dart';
import '../firebase/auth.dart';

class OrderApi {
  Stream<QuerySnapshot> getAllOrder() {
    return firebaseFirestore.collection(AppSecrets.consumerorder).snapshots();
  }

  Future<List<Map<String, dynamic>>> getOrderByUser(
      {required String userid}) async {
    List<Map<String, dynamic>> tempList = [];
    var response =
        await firebaseFirestore.collection(AppSecrets.consumerorder).get();
    for (var ele in response.docs) {
      if (userid == ele.data()["userid"]) {
        tempList.add(ele.data());
      }
    }
    return tempList;
  }
  
}
