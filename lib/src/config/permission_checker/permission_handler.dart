import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/atoms/appalertdialog.dart';

abstract class PermissionService {
  Future requestPhotosPermission();

  Future<bool> handlePhotosPermission(BuildContext context);

  Future requestCameraPermission();

  Future<bool> handleCameraPermission(BuildContext context);

  Future requestLocationPermission();

  Future<bool> handleLocationPermission(BuildContext context);
}

class PermissionHandlerPermissionService implements PermissionService {
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.storage.request();
  }

  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (context) => AppAlertDialog(
          onYes: () => openAppSettings(),
          title: 'Camera Permission',
          content:
              'Camera permission should Be granted to use this feature, would you like to go to app settings to give camera permission?',
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    PermissionStatus photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (context) => AppAlertDialog(
          onYes: () => openAppSettings(),
          title: 'Photos Permission',
          content:
              'Photos permission should Be granted to use this feature, would you like to go to app settings to give photos permission?',
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handleLocationPermission(BuildContext context) async {
    PermissionStatus photosPermissionStatus = await requestLocationPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (context) => AppAlertDialog(
          onYes: () => openAppSettings(),
          title: 'Location Permission',
          content:
              'Location permission should Be granted to use this feature, would you like to go to app settings to give photos permission?',
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future requestLocationPermission() async {
    return await Permission.location.request();
  }
}
