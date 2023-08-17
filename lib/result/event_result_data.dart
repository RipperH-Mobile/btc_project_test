class EventResultData<T> {
  final T result;
  final String? message;

  EventResultData({
    required this.result,
    this.message,
  });
}
