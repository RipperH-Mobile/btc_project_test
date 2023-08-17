import 'package:dio/dio.dart';

import 'app_result.dart';

class Errors<T> extends AppResult<T> {
  final Exception? exception;
  final DioError? dioError;

  Errors({this.exception, this.dioError});
}
