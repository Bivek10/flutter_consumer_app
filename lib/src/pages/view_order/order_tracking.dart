import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_skeleton/src/widgets/molecules/header.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingMap extends StatefulWidget {
  final Map<String, dynamic> homeloc;
  final Map<String, dynamic> riderlocation;
  const OrderTrackingMap(
      {Key? key, required this.homeloc, required this.riderlocation})
      : super(key: key);

  @override
  State<OrderTrackingMap> createState() => _OrderTrackingMapState();
}

class _OrderTrackingMapState extends State<OrderTrackingMap> {
  Set<Marker> markers = {};

// make sure to initialize before map loading

  Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];
  late LatLng startLocation;
  late LatLng endLocation;
  List<LatLng> latLen = [];

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
            zoom: 15,
          ),
          onTap: (LatLng) {}),
    );
  }

  setMaker() async {
    startLocation = LatLng(widget.homeloc["lat"], widget.homeloc["long"]);
    endLocation =
        LatLng(widget.riderlocation["lat"], widget.riderlocation["long"]);

    latLen = [startLocation, endLocation];

    markers.addAll(
      // added markers
      {
        Marker(
          markerId: MarkerId(latLen[1].toString()),
          position: latLen[1],
          infoWindow: const InfoWindow(
            title: 'Delivery Boy',
            snippet: 'Order On the way',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
        Marker(
          markerId: MarkerId(latLen[0].toString()),
          position: latLen[0],
          infoWindow: const InfoWindow(
            title: 'Destination',
            snippet: 'User location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
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
