import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/widgets/atoms/menu_button.dart';

import '../../config/api/manage_food_api.dart';
import '../../config/routes/routesname.dart';
import '../../widgets/atoms/loader.dart';
import '../../widgets/molecules/header.dart';
import '../manage_table/add_table.dart';
import 'category_base.dart';

class CategoryHome extends StatefulWidget {
  static const String pageUrl = "/categoryhome";
  const CategoryHome({Key? key}) : super(key: key);

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
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
          stream: manageFoodApi.getCategoryInfo(),
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
                return CategoryBase(categoryData: data[index]);
              });
            }
            return const Center(child: Loader());
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MenuButton(
                  showIcon: true,
                  iconname: Icons.add,
                  color: Colors.orange,
                  menuTxt: "Add Category",
                  onClick: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.categoryform,
                      arguments: EditFormValue(false, {}, ""),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
