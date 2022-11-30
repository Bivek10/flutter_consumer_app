import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_skeleton/src/widgets/molecules/header.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingMap extends StatefulWidget {
  final Map<String, dynamic> loc;
  const OrderTrackingMap({Key? key, required this.loc}) : super(key: key);

  @override
  State<OrderTrackingMap> createState() => _OrderTrackingMapState();
}

class _OrderTrackingMapState extends State<OrderTrackingMap> {
  Set<Marker> markers = {};
  LatLng startLocation = LatLng(
    double.parse("27.708869977980832"),
    double.parse("85.32769817858934"),
  );
  LatLng endLocation = LatLng(
    double.parse("27.710372210171386"),
    double.parse("85.3283955529332"),
  );

  //27.710372210171386, 85.3283955529332

  setMaker() {
    markers.addAll({
      Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
      Marker(
        //add start location marker
        markerId: MarkerId(endLocation.toString()),
        position: endLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
    });
  }

  @override
  void initState() {
    setMaker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Track Order",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
      ),
      body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          buildingsEnabled: false,
          onMapCreated: (GoogleMapController controller) {},
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: startLocation,
            zoom: 15,
          ),
          onTap: (LatLng) {}),
    );
  }
}
