import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../firebase/auth.dart';

class DioAuthInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(options.uri.toString());
    String? token = await firebaseAuth.currentUser?.getIdToken();
    if (token != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}

//https://api.spoonacular.com/food/menuItems/search?query=meat&number=10

class CacheInterceptor extends Interceptor {
  final _cache = <Uri, Response>{};

  @override
  onRequest(options, handler) => handler.next(options);

  @override
  onResponse(response, handler) {
    // Cache the response with uri as key
    _cache[response.requestOptions.uri] = response;

    handler.resolve(response);
  }

  @override
  onError(DioError err, handler) {
    var isTimeout = err.type == DioErrorType.connectTimeout;
    var isOtherError = err.type == DioErrorType.other;

    if (isTimeout || isOtherError) {
      // Read cached response if available by uri as key
      var cachedResponse = _cache[err.requestOptions.uri];

      if (cachedResponse != null) {
        // Resolve with cached response
        return handler.resolve(cachedResponse);
      }
    }

    return handler.next(err);
  }
}
