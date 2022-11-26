import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../config/routes/routesname.dart';
import '../injector.dart';
import '../providers/email_auth_provider.dart';
import '../widgets/atoms/menu_button.dart';
import '../widgets/molecules/header.dart';

class Profile extends StatefulWidget {
  static const pageUrl = "/profile";
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String email;
  @override
  void initState() {
    onSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Profile",
        onPressedAction: () {},
        onPressedLeading: () {},
        showAction: false,
        showMenu: false,
      ),
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 50.sp,
              child: Icon(
                Icons.person,
                color: Colors.orangeAccent,
                size: 50.sp,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email,
                color: Colors.black,
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          MenuButton(
            color: Colors.black,
            menuTxt: "Log Out",
            showIcon: false,
            iconname: Icons.logout,
            onClick: () async {},
          )
        ],
      ),
    );
  }

  void onSet() {
    email = sharedPreferences.getString("email")!;
  }
}
