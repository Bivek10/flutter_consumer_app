import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/snack_bar.dart';
import '../../models/menu_item_mode.dart';

class MenuItemBase extends StatelessWidget {
  const MenuItemBase({Key? key, required this.menuItems}) : super(key: key);

  final MenuItems menuItems;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: menuItems.id!,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Material(
            elevation: 1.5,
            borderRadius: BorderRadius.circular(8),
            shadowColor: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    menuItems.restaurantChain.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40.sp,
                  height: 40.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/logo.png',
                      image: menuItems.image.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 2,
                  ),
                  child: Text(
                    menuItems.title.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showError(message: "Comming soon...");
                  },
                  child: Container(
                    height: 20.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.orangeAccent,
                    ),
                    child: Center(
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
