import 'app_result.dart';

class Success<T> extends AppResult<T> {
  final T value;
  final bool? isNextPageAvailable;
  final int? currentPage;

  Success({
    required this.value,
    this.isNextPageAvailable,
    this.currentPage,
  });
}
