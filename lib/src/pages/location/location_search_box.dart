import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/colors.dart';
import 'location_provider/location_pick_prov.dart';

class LocationSearchBox extends StatelessWidget {
  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  final TextEditingController searchCtrl;

  LocationSearchBox({
    required this.searchCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: TextFormField(
        controller: searchCtrl,
        cursorColor: Colors.orange,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: pink,
          focusedBorder: _border(pink),
          border: _border(grey),
          enabledBorder: _border(grey),
          hintText: 'Enter Your Location',
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: AppColors.greyDark,
            height: 1,
            letterSpacing: 0.2,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (searchCtrl.text.isNotEmpty) {
                searchCtrl.clear();
              }
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue.shade200,
          ),
        ),
        onChanged: (value) {
          // Provider.of<LocationPickerProvider>(context, listen: false)
          //     .getSearchPlaceData(searchInput: value);
        },
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: color),
        borderRadius: BorderRadius.circular(5),
      );
}
