import 'btc_funtion/btc_response.dart';

abstract class ICacheSession {
  Future<bool> initialize();
  void addCartList(BtcDetailResponse? valueList);

  BtcDetailResponse? getStoreCart();
  void clearStoreCart();
}
