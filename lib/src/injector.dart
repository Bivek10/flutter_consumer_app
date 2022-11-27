import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/api/api.dart';
import 'config/permission_checker/permission_handler.dart';

late SharedPreferences sharedPreferences;
late PermissionHandlerPermissionService permissionHandler;

Future<void> initializeDependencies() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  await Firebase.initializeApp();

  // init dio
  InitDio();

  sharedPreferences = await SharedPreferences.getInstance();
  permissionHandler = PermissionHandlerPermissionService();
}
