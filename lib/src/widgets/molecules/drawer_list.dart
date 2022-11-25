import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerList extends StatelessWidget {
  final String text;
  final Color? textColor;
  final IconData iconData;
  final Function? tap;

  const DrawerList({
    required this.text,
    this.textColor,
    required this.tap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 20.sp,
      ),
      onTap: () {
        tap!();
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),
          )
        ],
      ),
    );
  }
}
