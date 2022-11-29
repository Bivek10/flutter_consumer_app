import 'package:flutter/cupertino.dart';
import 'package:flutter_skeleton/src/models/place_auto_complete.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../location_function/location_picker_function.dart';

class LocationPickerProvider with ChangeNotifier {
  //create instance of UserLocationPicker data
  UserLocationPicker userLocationPicker = UserLocationPicker();

  List<PlaceAutocomplete>? _searchPlaceData;
  LatLng? _latLng;
  void getCurrentLocation() async {
    Position position = await userLocationPicker.getCurrentLocation();
    _latLng = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  List<PlaceAutocomplete>? get getPlaceAutocomplete => _searchPlaceData;
  LatLng? get getLatlagn => _latLng;
}
