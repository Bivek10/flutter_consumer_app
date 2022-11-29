import 'package:dio/dio.dart';

import '../../core/utils/app_secrets.skeleton.dart';
import '../../models/place_auto_complete.dart';
import '../../models/place_model.dart';
import 'dart:convert' as convert;

class GetPlaceBySearch extends BasePlacesRepository {
  Dio dio = Dio();
  @override
  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=${AppSecrets.maptypes}&key=${AppSecrets.mapkey}';

    var response = await dio.get(url);

    var json = response.data;
    print(json);
    var results = json['predictions'] as List;
    print(results);
    return results.map((place) => PlaceAutocomplete.fromJson(place)).toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppSecrets.mapkey}';
      
    var response = await dio.get(url);
    var json = convert.jsonDecode(response.data);
    var results = json['result'] as Map<String, dynamic>;

    Place place = Place.fromJson(results);

    return place;
  }
}

abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput);
  Future<Place?> getPlace(String placeId);
}
