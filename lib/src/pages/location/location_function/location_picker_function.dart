import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../injector.dart';
import '../delivery_location_picker.dart';

class UserLocationPicker extends LocationPickerImpl {
  @override
  Future<bool> checkLocationPermission({required BuildContext context}) async {
    bool isLocationEnable =
        await permissionHandler.handleLocationPermission(context);
    return isLocationEnable;
  }

  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    late Future<Position> currentpoistion;
    permission = await Geolocator.checkPermission();
    //print(permission.name);
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      currentpoistion = Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        currentpoistion = Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }
    }

    return await currentpoistion;
  }
}

abstract class LocationPickerImpl {
  void checkLocationPermission({required BuildContext context});
  Future<Position> getCurrentLocation();
}
