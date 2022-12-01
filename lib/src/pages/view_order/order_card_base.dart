import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/pages/view_order/order_tracking.dart';

import '../../core/utils/snack_bar.dart';

class OrderBaseCard extends StatelessWidget {
  final Map<String, dynamic> orderdata;

  const OrderBaseCard({Key? key, required this.orderdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "ORDER SUMMARY",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (orderdata["orderstatus"] == "pending") {
                        showError(
                            message:
                                "Order is not processed. Please be patience");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderTrackingMap(
                              homeloc: orderdata["location"],
                              riderlocation: orderdata["rider_location"],
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.black45,
              ),
              orderinfoList(context, "DateTime", orderdata["datetime"] ?? ""),
              orderinfoList(context, "Item purchased", orderdata["items"]),
              orderinfoList(context, "Order status", orderdata["orderstatus"]),
              orderinfoList(
                context,
                "Sub-total",
                "Rs. ${orderdata["totalamount"].toString()}",
              ),
              orderinfoList(context, "Shipping-charges", "Rs. 00"),
              const Divider(
                color: Colors.black45,
              ),
              orderinfoList(context, "Grand-Total",
                  "Rs. ${orderdata["totalamount"].toString()}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget orderinfoList(context, String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
