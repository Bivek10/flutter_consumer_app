import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/config/api/table_order_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/atoms/loader.dart';
import 'location_provider/location_pick_prov.dart';
import 'location_search_box.dart';

class DeliveryLocationPicker extends StatefulWidget {
  final Map<String, dynamic> data;
  const DeliveryLocationPicker({Key? key, required this.data})
      : super(key: key);

  @override
  State<DeliveryLocationPicker> createState() => _DeliveryLocationPickerState();
}

class _DeliveryLocationPickerState extends State<DeliveryLocationPicker> {
  Set<Marker> markers = {};
  TextEditingController searchTxtCtrl = TextEditingController();
  LatLng? startLocation;

  @override
  void initState() {
    super.initState();
    setInitData();
  }

  setInitData() {
    Provider.of<LocationPickerProvider>(context, listen: false)
        .getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocationAppBar(context, searchTxtCtrl),
      body: Consumer<LocationPickerProvider>(
        builder: (context, value, child) {
          if (value.getLatlagn != null) {
            markers.add(
              Marker(
                //add start location marker
                markerId: MarkerId(value.getLatlagn.toString()),
                position: value.getLatlagn!,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
            );

            return Stack(
              children: [
                GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    buildingsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {},
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                      target: value.getLatlagn!,
                      zoom: 15,
                    ),
                    onTap: (LatLng) {
                      markers.clear();
                      Provider.of<LocationPickerProvider>(context,
                              listen: false)
                          .getOnTapLocation(LatLng);
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
                        value: value,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                        ),
                        child: InkWell(
                          onTap: () {
                            widget.data["delivery_location"] = {
                              "lat": value.getLatlagn!.latitude,
                              "long": value.getLatlagn!.longitude
                            };
                            value.getLatlagn.toString();
                            TableOrderApi tableOrderApi = TableOrderApi();
                            tableOrderApi.updateOrderStatus(
                                data: widget.data, context: context);
                            // print(widget.data);
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
                                    "Set Location & Order",
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
            );
          }
          return const Center(
            child: Loader(),
          );
        },
      ),
    );
  }
}

class _SearchBoxSuggestions extends StatelessWidget {
  final TextEditingController searchCtrl;
  final LocationPickerProvider value;
  const _SearchBoxSuggestions({
    Key? key,
    required this.searchCtrl,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: value.getPlaceAutocomplete.length,
      itemBuilder: (context, index) {
        String description = value.getPlaceAutocomplete[index].description;
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                description,
                style: const TextStyle(
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
