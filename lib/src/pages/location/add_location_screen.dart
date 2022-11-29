// import 'package:flutter/material.dart';
// import 'package:flutter_skeleton/src/core/utils/dimensions.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_home/Modules/check_out/bloc/address_bloc/address_bloc_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:developer' as dev;
// import '../../../Common/utils/colors.dart';
// import '../../../Common/utils/dimensions.dart';
// import 'address_form.dart';

// class AddDeliveryLocation extends StatefulWidget {
//   final Map locatindetails;
//   final AddressBlocBloc outerAddressBloc;

//   const AddDeliveryLocation(
//       {Key? key, required this.locatindetails, required this.outerAddressBloc})
//       : super(key: key);

//   @override
//   State<AddDeliveryLocation> createState() => _AddDeliveryLocationState();
// }

// class _AddDeliveryLocationState extends State<AddDeliveryLocation> {
//   Set<Marker> markers = {};
//   LatLng? selectedLocation;
//   List<Placemark>? placemark;
//   String addressTitle = "";
//   Map deliveryDetail = {};
//   @override
//   void initState() {
//     super.initState();
//     configureMarkers();
//   }

//   Future<void> configureMarkers() async {
   
//     selectedLocation = LatLng(
//       double.parse(widget.locatindetails["lat"]),
//       double.parse(widget.locatindetails["lag"]),
//     );
//     placemark = await placemarkFromCoordinates(
//       double.parse(widget.locatindetails["lat"]),
//       double.parse(widget.locatindetails["lag"]),
//     );

//     // dev.log("placemark ${placemark}");

//     addressTitle =
//         "${placemark![0].street}${placemark![1].thoroughfare},${placemark![1].locality},${placemark![1].postalCode},${placemark![1].country} ";
//     deliveryDetail.addAll(
//       {
//         "street": placemark![0].street,
//         "latitude": widget.locatindetails["lat"],
//         "longitude": widget.locatindetails["lag"],
//         "city": placemark![0].thoroughfare,
//         "locality": placemark![0].locality,
//         "postalcode": placemark![1].postalCode,
//         "country": placemark![1].country,
//       },
//     );
//     // print(deliveryDetail);
//     //  print(addressTitle);
//     markers.add(
//       Marker(
//         //add start location marker
//         markerId: MarkerId(selectedLocation.toString()),
//         position: selectedLocation!, //position of marker

//         icon: BitmapDescriptor.defaultMarkerWithHue(
//           BitmapDescriptor.hueRed,
//         ),
//       ),
//     );
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 6 / 3,
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: false,
//                     buildingsEnabled: false,
//                     markers: markers,
//                     scrollGesturesEnabled: false,
//                     zoomControlsEnabled: false,
//                     initialCameraPosition: CameraPosition(
//                       target: selectedLocation!,
//                       zoom: 15,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     right: 5,
//                     child: SizedBox(
//                       width: Dimensions.width(context) / 1.5,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               addressTitle,
//                               maxLines: 2,
//                               textAlign: TextAlign.end,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: Colors.blue.shade200,
//                                 letterSpacing: -0.5,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
           
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.blue.shade200,
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(
//           Icons.chevron_left,
//           size: 35,
//           color: Colors.white,
//           // color: Color.fromRGBO(255, 141, 13, 1),
//         ),
//       ),
//       title: const Text(
//         "ADD ADDRESS",
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w700,
//           fontStyle: FontStyle.normal,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
