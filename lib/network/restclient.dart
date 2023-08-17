import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../result/response_status.dart';

class RestClient extends Interceptor {
  final Dio dio = Dio();
  int? device;
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "ACCEPT": "application/json",
  };

  RestClient() {
    _initInterceptors();
    device;
  }

  _initInterceptors() {
    dio.interceptors.add(_interceptorsWrapper());
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  InterceptorsWrapper _interceptorsWrapper() => InterceptorsWrapper(onRequest: (options, handler) async {
        var deviceType = device.toString();
        if (options.data is FormData) {
          _headers.clear();
        }
        if (deviceType.isNotEmpty == true) {
          _headers['device_type'] = deviceType.toString();
        } else {
          _headers.remove("device_type");
        }
        _headers.remove("content-length");
        options.headers = _headers;

        return handler.next(options);
      }, onResponse: (Response response, ResponseInterceptorHandler handler) async {
        return handler.next(response);
      }, onError: (DioError err, ErrorInterceptorHandler handler) async {
        switch (err.type) {
          case DioErrorType.sendTimeout:
            break;
          case DioErrorType.receiveTimeout:
            break;
          case DioErrorType.cancel:
            break;
        }
        return handler.next(err);
      });

  void dispose() {
    dio.close();
  }
}
