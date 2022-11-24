import 'package:flutter/material.dart';

import '../../config/routes/routesname.dart';
import '../../config/themes/app_theme.dart';
import '../../widgets/atoms/menu_button.dart';
import 'roms_table.dart';

class HomePage extends StatefulWidget {
  static const pageUrl = "/Home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Table View",
          style: AppTheme.subHeading,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.profile);
            },
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: const TableViews(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: MenuButton(
                iconname: Icons.add,
                color: Colors.black,
                menuTxt: "Add Table",
                onClick: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
