import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_skeleton/src/pages/categories/category_base.dart';

import '../../config/api/manage_food_api.dart';
import '../../widgets/atoms/loader.dart';
import '../../widgets/molecules/header.dart';
import 'food_setting_base.dart';

class FoodSetting extends StatefulWidget {
  final String categoryID;
  const FoodSetting({Key? key, required this.categoryID}) : super(key: key);

  @override
  State<FoodSetting> createState() => _FoodSettingState();
}

class _FoodSettingState extends State<FoodSetting> {
  ManageFoodApi manageFoodApi = ManageFoodApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Manage Food",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: manageFoodApi.getFoodByCatID(widget.categoryID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> data = snapshot.data!.docs.map((e) {
                Map<String, dynamic> v = {"uid": e.id};
                v.addAll(e.data() as Map<String, dynamic>);

                return v;
              }).toList();

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FoodBaseSetting(
                      foodData: data[index],
                      categoryID: widget.categoryID,
                    );
                  });
            }
            return const Center(child: Loader());
          }),
    );
  }
}
