import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../config/api/manage_table_api.dart';
import '../../config/api/user_info_api.dart';
import '../../config/routes/routesname.dart';
import '../../widgets/atoms/loader.dart';
import '../../widgets/atoms/menu_button.dart';
import '../../widgets/molecules/drawerwidget.dart';
import '../../widgets/molecules/header.dart';
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
    UserCached.userrole = userdata["role"];
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
      body: StreamBuilder<QuerySnapshot>(
          stream: manageTableApi.getTableInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> data = snapshot.data!.docs.map((e) {
                Map<String, dynamic> v = {"uid": e.id};
                v.addAll(e.data() as Map<String, dynamic>);

                return v;
              }).toList();

              return TableViews(
                tabledata: data,
              ); // print(data.length);

            }
            return const Center(child: const Loader());
          }),
      bottomNavigationBar: UserCached.userrole == "Admin"
          ? Padding(
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
                        menuTxt: "Add Table",
                        onClick: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.addtable,
                            arguments: EditFormValue(false, {}, ""),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
