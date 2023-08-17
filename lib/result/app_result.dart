
import 'package:btc_project/result/success.dart';

import 'error.dart';

abstract class AppResult<T> {
  R whenWithResult<R>(
      R Function(Success<T> value) success, R Function(Errors error) error) {
    if (this is Success<T>) {
      return success(this as Success<T>);
    } else if (this is Errors) {
      return error(this as Errors);
    } else {
      throw Exception('Unhandled part, could be anything');
    }
  }
}
