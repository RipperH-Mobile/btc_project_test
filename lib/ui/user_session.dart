import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'btc_funtion/btc_response.dart';
import 'i_user_session.dart';

class UserSession implements ICacheSession {
  SharedPreferences? _prefs;
  BtcDetailResponse? _addCartList;

  @override
  Future<bool> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _prefs = prefs;

    final addCartJsonString = _prefs?.getString("usd");
    if (addCartJsonString != null) {
      final addCartJson = jsonDecode(addCartJsonString);
      _addCartList = BtcDetailResponse.fromJson(addCartJson);
    }

    return true;
  }



  @override
  BtcDetailResponse? getStoreCart() {
    return _addCartList;
  }

  @override
  void addCartList(BtcDetailResponse? storeCart) {
    _addCartList = storeCart;
    if (_addCartList != null) {
      final patientMap = _addCartList?.toJson();
      final jsonString = jsonEncode(patientMap);
      _prefs?.setString('usd', jsonString);
    }
  }

  @override
  void clearStoreCart() {
    _addCartList = null;
    _prefs?.remove('usd');
  }

}
