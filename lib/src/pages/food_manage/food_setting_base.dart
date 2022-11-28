import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_skeleton/src/config/routes/routesname.dart';

import '../../config/api/manage_food_api.dart';
import '../../widgets/atoms/dialoug.dart';
import '../categories/add_food_form.dart';
import '../manage_table/add_table.dart';

class FoodBaseSetting extends StatefulWidget {
  final String categoryID;
  final Map<String, dynamic> foodData;
  const FoodBaseSetting({
    Key? key,
    required this.foodData,
    required this.categoryID,
  }) : super(key: key);

  @override
  State<FoodBaseSetting> createState() => _FoodBaseSettingState();
}

class _FoodBaseSettingState extends State<FoodBaseSetting> {
  @override
  Widget build(BuildContext context) {
    //print(widget.foodData);
    return ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/logo.png',
            image: widget.foodData["imageurl"] ??
                "https://cdn-icons-png.flaticon.com/512/242/242452.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(
        widget.foodData["foodname"].toString().toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      trailing: PopupMenuButton(
        child: const Icon(
          Icons.more_vert,
          color: Colors.red,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit"),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
            ),
          ),
        ],
        onSelected: (value) {
          switchValue(value as int);
        },
      ),
    );
  }

  switchValue(int value) {
    switch (value) {
      case 1:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddFoodMenu(
              categoryID: widget.categoryID,
              isEdit: true,
              editMenuData: widget.foodData,
            ),
          ),
        );
      case 2:
        return showDialog(
          context: context,
          builder: (context) {
            return ConfirmDialog(
                onYes: () {
                  ManageFoodApi manageFoodApi = ManageFoodApi();
                  manageFoodApi.deleteFoodItem(
                      categoryID: widget.categoryID,
                      fooduid: widget.foodData["uid"],
                      context: context);
                },
                content: "Are you sure want to delete items?");
          },
        );
    }
  }
}
