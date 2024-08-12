import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';

abstract class ApiRepository{
  static final dio = Dio();
  static final PersistCookieJar _persistCookieJar = PersistCookieJar(deleteHostCookiesWhenLoadFailed: true, ignoreExpires: true);
  static bool _isDioInitialized = false;

  ApiRepository(){
    // Dio should be initialized only 1 time.
    if(!_isDioInitialized){
      _isDioInitialized = true;
      _dioInit();
    }
  }

  void _dioInit(){
    dio.options.baseUrl = 'http://localhost:5124';
    // dio.options.connectTimeout = const Duration(seconds: 5);
    // dio.options.receiveTimeout = const Duration(seconds: 5);
    if(!kIsWeb){
      dio.interceptors.add(CookieManager(_persistCookieJar));
    }
  }
}