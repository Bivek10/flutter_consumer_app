import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

import '../../core/utils/app_secrets.skeleton.dart';
import '../../models/menu_item_mode.dart';

class MenuAPICtrl {
  final CacheStore cacheStore;
  final CacheOptions cacheOptions;
  final Dio dio;

  MenuAPICtrl(this.cacheStore, this.cacheOptions, this.dio);

  Future<Response?> _call({
    required String url,
    CachePolicy? policy,
  }) {
    Options? options;
    options = cacheOptions.copyWith(policy: policy).toOptions();
    options.headers = AppSecrets.headers;

    try {
      return dio.get(
        url,
        options: options,
      );
    } on DioError catch (err) {
      return Future.value(null);
    }
  }

  Future<MenuItemModel> requestCall(String url) async {
    final resp = await _call(url: url);
    if (resp == null) {
      return MenuItemModel.erroMessage({"error": "No response"});
    }
    //return resp.toString();
    return _getResponseContent(resp);
  }

  Future<MenuItemModel> forceCacheCall(String url) async {
    final resp = await _call(url: url, policy: CachePolicy.forceCache);
    if (resp == null) {
      return MenuItemModel.erroMessage({"error": "No response"});
    }
    return _getResponseContent(resp);
  }
}

/*

 static Future<dynamic> getMenuData() async {
    try {
      Dio dio = Dio()..interceptors.add(DioCacheInterceptor(options: options));
      var response = dio.get(
        Config.apiUrl + "search?query=meat&number=10",
        options: Options(
          headers: AppSecrets.headers,
        ),
      );
      return response;
    } catch (e, s) {
      throw s;
    }
  }


*/

MenuItemModel _getResponseContent(Response response) {
  MenuItemModel menuItemModel = MenuItemModel.fromJson(response.data);
  return menuItemModel;
}
