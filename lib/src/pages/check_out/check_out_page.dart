import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/widgets/atoms/button.dart';

import 'package:sizer/sizer.dart';
import '../../config/api/manage_table_api.dart';
import '../../config/api/table_order_api.dart';
import '../../injector.dart';
import '../display_menu/product_menu_list.dart';
import '../location/delivery_location_picker.dart';
import '../location/location_function/location_picker_function.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  TableOrderApi tableOrderApi = TableOrderApi();
  List<Map<String, dynamic>> filterdata = [];
  String? userid;

  @override
  void initState() {
    userid = sharedPreferences.getString("uid");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder<QuerySnapshot>(
          stream: tableOrderApi.getcartByUserid(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              filterdata.clear();
              List<Map<String, dynamic>> data = snapshot.data!.docs
                  .map((e) {
                    Map<String, dynamic> datas =
                        e.data() as Map<String, dynamic>;
                    datas.addAll({"cartuid": e.id});
                    return datas;
                  })
                  .toList()
                  .where((element) {
                    return element["userid"] == userid &&
                        element["isorder"] == true;
                  })
                  .toList();

              filterdata.addAll(data);

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.blue.shade200,
                    floating: true,
                    pinned: true,
                    snap: false,
                    centerTitle: false,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      "Check Out",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                          Positioned(
                            top: 4,
                            right: 10,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text(
                                data.length.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: ProductMenuList(
                      isCheckout: true,
                      data: data,
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: 8.0,
          right: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Button(
                  //start loading,
                  loader: false,
                  fillColor: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(8),
                  size: ButtonSize.small,
                  trailingIcon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    DateTime currentTime = DateTime.now();
                    num totalbill = 0;

                    for (var ele in filterdata) {
                      totalbill += int.parse(ele["subtotal"].toString());
                    }
                    Map<String, dynamic> data = {
                      "userid": userid,
                      "orderData": filterdata,
                      "totalamount": totalbill,
                      "orderStatus": "pending",
                      "datetime": currentTime.toString(),
                      "delivery_location": {},
                    };
                    onCheckOut(context, data);
                  },

                  child: const Text(
                    "Confrim Order",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onCheckOut(BuildContext context, Map<String, dynamic> data) async {
    UserLocationPicker userLocationPicker = UserLocationPicker();
    userLocationPicker.checkLocationPermission(context: context).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => DeliveryLocationPicker(data: data)),
        ),
      );
    });
  }
}
