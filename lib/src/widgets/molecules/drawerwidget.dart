import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/user_info_api.dart';
import '../../config/routes/routesname.dart';
import '../../config/themes/colors.dart';
import '../../providers/email_auth_provider.dart';
import 'drawer_list.dart';

class DrawerWidget extends StatefulWidget {
  final Map<String, dynamic> userinfo;
  const DrawerWidget({Key? key, required this.userinfo}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final ScrollController x = ScrollController();
  Map<String, dynamic> userdetails = {};
  List<String> pages = ["View Orders", "Log Out"];
  List<IconData> icons = [
    Icons.delivery_dining,
    Icons.logout,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: x,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 170.sp,
          padding: EdgeInsets.only(top: 15.sp),
          decoration: BoxDecoration(
            color: AppColors.blue.withOpacity(0.5),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 80,
                child: Image.asset("assets/images/logo.png"),
              ),
              Text(
                "Welcome, ",
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                widget.userinfo["usernmae"] ?? "",
                style: TextStyle(fontSize: 14.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.userinfo["email"] ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ...List.generate(
          pages.length,
          (index) => DrawerList(
            iconData: icons[index],
            text: pages[index],
            tap: () async {
              if (index == 0) {
                Navigator.pushNamed(context, RouteName.categoryHome);
              }

              if (index == 1) {
                bool isLogout = await Provider.of<EmailAuthentication>(context,
                        listen: false)
                    .signOut();
                if (isLogout) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(context, RouteName.mainPage,
                      (Route<dynamic> route) => false);
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
