import '../../core/utils/app_mixin.dart';
import '../../core/utils/app_secrets.skeleton.dart';
import '../../core/utils/snack_bar.dart';
import '../../injector.dart';
import '../firebase/auth.dart';

class UserInfoAPI with ConnectivityMixin {
  Future<Map<String, dynamic>> getLoggedUserInfo() async {
    Map<String, dynamic> data = {};
    if (await isInConnection()) {
      if (UserCached.userdata.isNotEmpty) {
        data = UserCached.userdata;
        //print('yes');
      } else {
        String uid = sharedPreferences.getString('uid')!;
        firebaseFirestore
            .collection(AppSecrets.staffcollection)
            .doc(uid)
            .get()
            .then((value) {
          UserCached.userdata = value.data()!;
          data = value.data()!;
        });
      }
    } else {
      data = {"error": "No connection"};
      showError(message: "No internet connection");
    }
    return data;
  }

  Map<String, dynamic> getUserInfo() {
    Map<String, dynamic> userinfo = {
      "usernmae": sharedPreferences.getString("name"),
      "role": sharedPreferences.getString("role")
    };
    return userinfo;
  }
}

class UserCached {
  static Map<String, dynamic> userdata = {};
  static String userrole="";
}
