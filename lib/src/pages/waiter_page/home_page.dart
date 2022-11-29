import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../../config/api/manage_table_api.dart';
import '../../config/api/user_info_api.dart';
import '../../config/routes/routesname.dart';
import '../../widgets/atoms/loader.dart';
import '../../widgets/atoms/menu_button.dart';
import '../../widgets/molecules/drawerwidget.dart';
import '../../widgets/molecules/header.dart';
import '../categories/manage_category_home.dart';
import '../display_menu/food_view.dart';
import '../manage_table/add_table.dart';
import 'roms_table.dart';

class HomePage extends StatefulWidget {
  static const pageUrl = "/Home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  late Map<String, dynamic> userdata;
  late ManageTableApi manageTableApi;
  @override
  void initState() {
    manageTableApi = ManageTableApi();
    UserInfoAPI userInfoAPI = UserInfoAPI();
    userdata = userInfoAPI.getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: Header(
          title: "Himalayan Resturents",
          onPressedAction: () {},
          onPressedLeading: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          showAction: false,
          showMenu: true,
        ),
        drawer: Drawer(
          child: DrawerWidget(
            userinfo: userdata,
          ),
        ),
        body: FoodMenu());
  }
}
