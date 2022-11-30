import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_skeleton/src/widgets/molecules/header.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/app_secrets.skeleton.dart';

class OrderTrackingMap extends StatefulWidget {
  final Map<String, dynamic> loc;
  const OrderTrackingMap({Key? key, required this.loc}) : super(key: key);

  @override
  State<OrderTrackingMap> createState() => _OrderTrackingMapState();
}

class _OrderTrackingMapState extends State<OrderTrackingMap> {
  Set<Marker> markers = {};

// make sure to initialize before map loading

  Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];
  LatLng startLocation = LatLng(
    double.parse("27.708869977980832"),
    double.parse("85.32769817858934"),
  );
  LatLng endLocation = LatLng(
    double.parse("27.710372210171386"),
    double.parse("85.3283955529332"),
  );
  List<LatLng> latLen = [];

  //27.710372210171386, 85.3283955529332

  /*
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
    */

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
          compassEnabled: false,
          polylines: _polyline,
          onMapCreated: (GoogleMapController controller) {},
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: startLocation,
            zoom: 16,
          ),
          onTap: (LatLng) {}),
    );
  }

  setMaker() async {
    latLen = [startLocation, endLocation];

    markers.addAll(
      // added markers
      {
        Marker(
          markerId: MarkerId(latLen[0].toString()),
          position: latLen[0],
          infoWindow: const InfoWindow(
            title: 'Delivery Boy',
            snippet: 'Order On the way',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
        Marker(
          markerId: MarkerId(latLen[1].toString()),
          position: latLen[1],
          infoWindow: const InfoWindow(
            title: 'Destination',
            snippet: 'User location',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      },
    );
    setState(() {});

    for (int i = 0; i < latLen.length; i++) {
      _polyline.add(
        Polyline(
          polylineId: const PolylineId('1'),
          points: latLen,
          width: 5,
          color: Colors.green,
        ),
      );
    }
  }
}
