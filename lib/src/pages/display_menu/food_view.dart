import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/widgets/atoms/button.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/manage_food_api.dart';
import '../../config/api/table_order_api.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/snack_bar.dart';
import '../../widgets/atoms/loader.dart';
import '../check_out/check_out_page.dart';
import '../waiter_page/roms_table.dart';
import 'category_button.dart';
import 'product_menu_list.dart';

class FoodMenu extends StatefulWidget {
  static const pageUrl = "/foodmenu";
  final TableModel tableModel;

  const FoodMenu({Key? key, required this.tableModel}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  ManageFoodApi manageFoodApi = ManageFoodApi();
  TableOrderApi tableOrderApi = TableOrderApi();

  List<Map<String, dynamic>> category = [];
  late Future<List<Map<String, dynamic>>> categorydata;
  List<String> isActive = [];
  late Future<List<Map<String, dynamic>>> productdata;
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> cartlist = [];

  @override
  void initState() {
    super.initState();
    getCategoires();
    //getData();
  }

  getCategoires() async {
    categorydata = manageFoodApi.getCategoryFuture();
    category = await categorydata;
    if (category.isNotEmpty) {
      isActive.add(category[0]["categoryid"]);
      getProducts(category[0]["uid"]);
    }
  }

  getProducts(String categoryID) async {
    productdata = manageFoodApi.getCategoryByMenu(categoryID);
    product = await productdata;
    if (product.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder(
          future: categorydata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                      "Food Menu",
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
                            child: StreamBuilder<QuerySnapshot>(
                                stream: tableOrderApi.getcartByTableid(
                                    tableid: widget.tableModel.tableid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    cartlist.clear();
                                    List<Map<String, dynamic>> data = snapshot
                                        .data!.docs
                                        .map((e) {
                                          Map<String, dynamic> datas =
                                              e.data() as Map<String, dynamic>;

                                          return datas;
                                        })
                                        .toList()
                                        .where((element) {
                                          return element["tableuid"] ==
                                              widget.tableModel.uid && element["isorder"]==true;
                                        
                                        })
                                        .toList();
                                    cartlist = data;

                                    return CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        data.length.toString(),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                }),
                          )
                        ],
                      ),
                    ],
                    bottom: PreferredSize(
                        preferredSize: Size(Dimensions.width(context), 50),
                        child: Container(
                          color: Colors.blue.shade200,
                          height: 60,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 5,
                                        ),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: category.length,
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                                  onTap: () {
                                                    if (isActive.contains(
                                                        category[index]
                                                            ["categoryid"])) {
                                                    } else {
                                                      isActive.clear();
                                                      isActive.add(
                                                          category[index]
                                                              ["categoryid"]);
                                                      getProducts(
                                                          category[index]
                                                              ["uid"]);
                                                    }
                                                  },
                                                  child: CategoryButton(
                                                    isSelected:
                                                        isActive.contains(
                                                            category[index]
                                                                ["categoryid"]),
                                                    data: category[index],
                                                  ),
                                                )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: FutureBuilder(
                        future: categorydata,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return ProductMenuList(
                              isCheckout: false,
                              data: product,
                              tableuid: widget.tableModel.uid,
                            );
                          }
                          return const Center(
                              child: SizedBox(
                                  height: 30, width: 30, child: Loader()));
                        })),
                  )
                ],
              );
            }
            return const Center(
                child: SizedBox(height: 30, width: 30, child: Loader()));
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
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
                    if (cartlist.isEmpty) {
                      showError(message: "Cart is empty");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CheckOutPage(
                                    tableid: widget.tableModel.uid,
                                  ))));
                    }
                  },

                  child: const Text(
                    "Check Out",
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
}
