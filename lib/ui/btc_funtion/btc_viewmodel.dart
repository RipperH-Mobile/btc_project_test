import 'dart:convert';
import 'dart:developer';

import 'package:btc_project/ui/reuse_file/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import '../../result/app_result.dart';
import 'btc_response.dart';
import '../feed_data.dart';

class BtcViewModel {

  BtcViewModel();

  Rxn<FeedData<BtcDetailResponse>> btcData = Rxn<FeedData<BtcDetailResponse>>();

  Future<BtcDetailResponse> fetchBTC() async {
    final response = await http
        .get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log("message ${response.body}");

      return BtcDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
