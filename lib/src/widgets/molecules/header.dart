import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
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
        "Profile",
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
