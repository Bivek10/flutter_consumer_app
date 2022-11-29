import 'dart:developer' as dev;

class Place {
  final String lat;
  final String lag;
  String? placeId;
  String? name;

  Place(
      {required this.lat,
      required this.lag,
      required this.placeId,
      required this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    if (json.keys.contains('place_id')) {
      dev.log("yes contain place name ${json['name']}");
      return Place(
        placeId: json['place_id'],
        name: json['name'],
        lat: json['geometry']['location']['lat'].toString(),
        lag: json['geometry']['location']['lng'].toString(),
      );
    } else {
      return Place(
        placeId: json['placeId'],
        name: json['name'],
        lat: json['lat'].toString(),
        lag: json['lon'].toString(),
      );
    }
  }
}
