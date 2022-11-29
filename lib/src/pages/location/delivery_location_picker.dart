import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_search_box.dart';

class DeliveryLocationPicker extends StatefulWidget {
  const DeliveryLocationPicker({Key? key}) : super(key: key);

  @override
  State<DeliveryLocationPicker> createState() => _DeliveryLocationPickerState();
}

class _DeliveryLocationPickerState extends State<DeliveryLocationPicker> {
  Set<Marker> markers = {};
  TextEditingController searchTxtCtrl = TextEditingController();
  late LatLng startLocation;
  @override
  void initState() {
    super.initState();
    setInitData();
  }

  setInitData() {
    startLocation = LatLng(
      double.parse("27.7056666"),
      double.parse("85.328234"),
    );

    markers.add(
      Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LocationAppBar(context, searchTxtCtrl),
        body: Stack(
          children: [
            GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                buildingsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  // locationBloc!.add(
                  //   LoadMap(controller: controller),
                  // );
                },
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: startLocation,
                  zoom: 15,
                ),
                onTap: (LatLng) {
                  print(LatLng);
                  // locationBloc!.add(
                  //   LoadMap(latLng: LatLng),
                }),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: [
                  _SearchBoxSuggestions(
                    searchCtrl: searchTxtCtrl,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                    ),
                    child: InkWell(
                      onTap: () {
                        Map locDetail = {
                          // "lat": state.place.lat,
                          // "lag": state.place.lag,
                          // "placename": state.place.name
                        };
                      },
                      child: Material(
                        shadowColor: Colors.grey,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.orange,
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                "Set Location",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  height: 1,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class _SearchBoxSuggestions extends StatelessWidget {
  final TextEditingController searchCtrl;
  const _SearchBoxSuggestions({
    Key? key,
    required this.searchCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // locationBloc.add(
            //   SearchLocation(
            //     placeId: state.autocomplete[index].placeId.toString(),
            //   ),
            // );
            // autocompleteBloc.add(ClearAutocomplete());

            // searchCtrl.text =
            //     state.autocomplete[index].description.toString();
            // FocusScopeNode currentFocus = FocusScope.of(context);

            // if (!currentFocus.hasPrimaryFocus) {
            //   currentFocus.unfocus();
            // }
            //print(state.autocomplete[index].toString());
          },
          child: Container(
            color: Colors.blue.shade200,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Hello world",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Color.fromARGB(255, 248, 248, 248),
                  height: 1,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

PreferredSizeWidget LocationAppBar(context, TextEditingController searchCtrl) {
  return AppBar(
    backgroundColor: Colors.blue.shade200,
    automaticallyImplyLeading: false,
    leadingWidth: 100,
    actions: [
      IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 35,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 18.0,
            left: 8,
            top: 8.0,
            bottom: 8.0,
          ),
          child: LocationSearchBox(
            searchCtrl: searchCtrl,
          ),
        ),
      )
    ],
  );
}
