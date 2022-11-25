import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config.dart';
import '../config/api/menu_api.dart';
import '../core/utils/app_mixin.dart';
import '../models/menu_item_mode.dart';
import '../widgets/molecules/header.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;

import '../widgets/menu_items_base.dart';

class MenuList extends StatefulWidget {
  static const pageUrl = "/menulist";
  const MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> with ConnectivityMixin {
  late Dio dio;
  late CacheStore cacheStore;
  late CacheOptions cacheOptions;
  late MenuAPICtrl menuAPICtrl;
  late MenuItemModel menuItem;
  @override
  void initState() {
    //getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Menu List",
        onPressedAction: () {},
        onPressedLeading: () {},
        showAction: false,
        showMenu: false,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MenuItemModel menuItemModel = snapshot.data as MenuItemModel;
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                //scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 145.sp,
                  childAspectRatio: 1.4 / 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                ),
                itemCount: menuItemModel.menuItems!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MenuItemBase(
                        menuItems: menuItemModel.menuItems![index]),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 188, 71, 255),
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        },
      ),
    );
  }

  Future<MenuItemModel> getData() async {
    pathprovider.getTemporaryDirectory().then((dir) {
      //print(dir.path);
      cacheStore = HiveCacheStore(dir.path);

      cacheOptions = CacheOptions(
        store: cacheStore,
        hitCacheOnErrorExcept: [], // for offline behaviour
      );

      dio = Dio()
        ..interceptors.add(
          DioCacheInterceptor(options: cacheOptions),
        );

      menuAPICtrl = MenuAPICtrl(cacheStore, cacheOptions, dio);
    });

    if (await isInConnection()) {
      menuItem = await menuAPICtrl
          .refreshForceCacheCall(Config.apiUrl + "search?query=meat&number=6");
    } else {
      menuItem = await menuAPICtrl
          .forceCacheCall(Config.apiUrl + "search?query=meat&number=6");
    }
    return menuItem;
  }
}
