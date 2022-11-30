import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../config/api/order_api.dart';
import '../../injector.dart';
import '../../widgets/atoms/loader.dart';
import '../../widgets/molecules/header.dart';
import 'order_card_base.dart';

class ViewOrder extends StatefulWidget {
  static const String pageUrl = "/orderpage";
  const ViewOrder({Key? key}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  OrderApi orderApi = OrderApi();
  late String userid;
  @override
  void initState() {
    userid = sharedPreferences.getString("uid")!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: Header(
        title: "Order History",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
      ),
      body: FutureBuilder<List>(
        future: orderApi.getOrderByUser(userid: userid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No order has made yet. ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var d = snapshot.data![index];
                  Map<String, dynamic> data = {
                    "datetime": d["datetime"],
                    "totalamount": d["totalamount"],
                    "orderstatus": d["orderStatus"],
                    "items": d["orderData"].length.toString(),
                    "location": d["delivery_location"]
                  };
                  return OrderBaseCard(orderdata: data);
                });
          }
          return const Center(
            child: Loader(),
          );
        },
      ),
    );
  }
}
