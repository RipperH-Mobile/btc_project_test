// ignore_for_file: unnecessary_getters_setters


import '../result/response_status.dart';

class FeedData<T> {
  List<T>? _feed;
  T? _data;
  T? _dataSearch;
  bool? _isLoading;
  bool? _isReload;
  int? _error;
  int? _currentPage;
  EventResult? _connected;

  FeedData(
      {List<T>? feedList,
      T? data,
      T? dataSearch,
      int? currentPage,
      bool? isNextPageAvailable,
      bool? isLoading,
      bool? isReload,
      int? error,
      EventResult? connected}) {
    _feed = feedList;
    _data = data;
    _dataSearch = dataSearch;
    _isLoading = isLoading;
    _isReload = isReload;
    _error = error;
    _currentPage = currentPage;
    _connected = connected;
  }

  List<T>? get feed => _feed;

  T? get data => _data;

  T? get dataSearch => _dataSearch;

  bool? get isLoading => _isLoading;

  bool? get isReload => _isReload;

  int? get error => _error;

  int? get currentPage => _currentPage;

  EventResult? get connected => _connected;

  set feed(List<T>? feed) {
    _feed = feed;
  }

  set data(T? data) {
    _data = data;
  }

  set dataSearch(T? dataSearch) {
    _dataSearch = dataSearch;
  }

  set isLoading(bool? isLoading) {
    _isLoading = isLoading;
  }

  set isReload(bool? isReload) {
    _isReload = isReload;
  }

  set error(int? error) {
    _error = error;
  }

  set currentPage(int? currentPage) {
    _currentPage = currentPage;
  }

  set connected(EventResult? connected) {
    _connected = connected;
  }
}
