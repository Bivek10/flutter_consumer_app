import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuButton extends StatelessWidget {
  final Color color;
  final bool showIcon;
  final String menuTxt;
  final IconData iconname;
  final Function onClick;
  const MenuButton({
    Key? key,
    required this.color,
    required this.menuTxt,
    required this.iconname,
    required this.onClick,
    required this.showIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Card(
        color: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Material(
            elevation: 0,
            // shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  showIcon
                      ? Card(
                          color: Colors.white,
                          child: Icon(
                            iconname,
                            color: Colors.black,
                            size: 16.sp,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    menuTxt,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      letterSpacing: 1,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
