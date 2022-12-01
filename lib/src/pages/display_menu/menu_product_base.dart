import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/table_order_api.dart';
import '../../injector.dart';
import '../../widgets/atoms/button.dart';

import 'edit_cart_button.dart';

class ProductListTile extends StatelessWidget {
  Map<String, dynamic> menuitem;

  final bool isCheckout;
  ProductListTile({Key? key, required this.menuitem, required this.isCheckout})
      : super(key: key);

  ValueNotifier<List<String>> isAdded = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/logo.png',
                image: menuitem["imageurl"] ??
                    "https://cdn-icons-png.flaticon.com/512/242/242452.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text(
                                menuitem["foodname"].toString().toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rs. ${int.parse(menuitem["price"]) - int.parse(menuitem["discount"])}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.orange,
                                ),
                              ),
                              menuitem["discount"] == "0"
                                  ? Container()
                                  : Text(
                                      "Rs. ${menuitem["price"]}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                            ],
                          ),
                          isCheckout
                              ? Text(
                                  "Subtotal: Rs. ${menuitem["subtotal"]}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    isCheckout == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: isAdded,
                                builder: (context, value, child) {
                                  return Button(
                                    //start loading,
                                    loader:
                                        isAdded.value.contains(menuitem["uid"]),
                                    fillColor: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                    size: ButtonSize.small,
                                    onPressed: () {
                                      Map<String, dynamic> data = {
                                        "productuid": menuitem["uid"],
                                        "price": menuitem["price"],
                                        "foodname": menuitem["foodname"],
                                        "discount": menuitem["discount"],
                                        "imageurl": menuitem["imageurl"],
                                        "quantity": "1",
                                        "isorder": true,
                                        "subtotal":
                                            int.parse(menuitem["price"]),
                                      };

                                      addToFoodCart(data);
                                    },

                                    child: const Text("Add"),
                                  );
                                },
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: isAdded,
                                builder: (context, value, child) {
                                  return EditCartButton(
                                    quantity: menuitem["quantity"],
                                    productId: "001",
                                    onIncrement: () {
                                      TableOrderApi tableOrderApi =
                                          TableOrderApi();
                                      tableOrderApi.incrementQuantity(
                                          data: menuitem,
                                          productname: menuitem["foodname"],
                                          cartuid: menuitem["cartuid"]);
                                    },
                                    onDecrement: () {
                                      TableOrderApi tableOrderApi =
                                          TableOrderApi();
                                      tableOrderApi.decrementQuantity(
                                          data: menuitem,
                                          productname: menuitem["foodname"],
                                          cartuid: menuitem["cartuid"]);
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addToFoodCart(Map<String, dynamic> data) {
    isAdded.value.clear();
    isAdded.value.add(data["productuid"]);
    String? userid = sharedPreferences.getString("uid");
    if (userid != null) {
      data.addAll({"userid": userid});
      TableOrderApi tableOrderApi = TableOrderApi();
      tableOrderApi.addToCart(
        data: data,
        productname: menuitem["foodname"],
      );
    }
  }
}
