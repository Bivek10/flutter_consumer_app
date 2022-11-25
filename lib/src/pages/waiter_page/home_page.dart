import 'package:flutter/material.dart';
import '../../config/api/user_info_api.dart';
import '../../config/routes/routesname.dart';
import '../../widgets/molecules/drawerwidget.dart';
import '../../widgets/molecules/header.dart';
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
  @override
  void initState() {
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
        showAction: true,
        showMenu: true,
      ),
      drawer: Drawer(
        child: DrawerWidget(
          userinfo: userdata,
        ),
      ),
      body: const TableViews(),
    );
  }
}


/*
  bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: MenuButton(
                showIcon: false,
                iconname: Icons.add,
                color: Colors.orange,
                menuTxt: "Add Table",
                onClick: () {},
              ),
            ),
          ),
        ],
      ),
    

*/