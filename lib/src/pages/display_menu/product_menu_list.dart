import 'package:flutter/material.dart';

import 'menu_product_base.dart';

class ProductMenuList extends StatelessWidget {
  final bool isCheckout;
  final List<Map<String, dynamic>> data;

  const ProductMenuList(
      {Key? key, required this.data, required this.isCheckout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          // print(data);
          //print(productdatas[index].previousPrice);
          return ProductListTile(
            isCheckout: isCheckout,
            menuitem: data[index],
          );
        });
  }
}
