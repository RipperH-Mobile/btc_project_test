import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../btc_funtion/btc_response.dart';

class SharedPref {
  static late SharedPreferences prefs;

   static Future<bool> initialize() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    prefs = prefss;

    final addCartJsonString = prefs.getString("usd");
    if (addCartJsonString != null) {
      final addCartJson = jsonDecode(addCartJsonString);
      _addCartList = BtcDetailResponse.fromJson(addCartJson);
    }
    return true;
  }

  static BtcDetailResponse? _addCartList;

  static  BtcDetailResponse? getStoreCart() {
    return _addCartList;
  }

  static void addCartList(BtcDetailResponse? data) {
    _addCartList = data;
    if (_addCartList != null) {
      final patientMap = _addCartList?.toJson();
      final jsonString = jsonEncode(patientMap);
      prefs.setString('usd', jsonString);
    }
  }

    static void clearStoreCart() {
      _addCartList = null;
      prefs.remove('usd');
    }


}
