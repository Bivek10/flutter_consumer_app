import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/routes/routesname.dart';
import '../atoms/filter_botton.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final bool showAction;
  final Function onPressedLeading;
  final Function onPressedAction;

  const Header(
      {Key? key,
      required this.title,
      required this.showMenu,
      required this.showAction,
      required this.onPressedLeading,
      required this.onPressedAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showMenu
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterButton(onPressed: () {
                onPressedLeading();
              }),
            )
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 20.sp,
              ),
            ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: showAction
          ? [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade200,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.profile);
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
