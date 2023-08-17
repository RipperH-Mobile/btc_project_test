
import 'package:btc_project/ui/btc_funtion/btc_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'btc_response.dart';

class BtcHistory extends StatefulWidget {
  BtcDetailResponse current;
  BtcDetailResponse history;

  BtcHistory({required this.current, required this.history, Key? key}) : super(key: key);

  @override
  State<BtcHistory> createState() => _BtcHistoryState();
}

class _BtcHistoryState extends State<BtcHistory> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("BTC History"),
          ),
          body: body( widget.current ,widget.history,)),
    );
  }

  body(BtcDetailResponse data, BtcDetailResponse history) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "ที่บันทึกไว้",
                      style: TextStyle(fontSize: 16, color: Colors.black , fontWeight: FontWeight.bold),
                    ),
                    dataDetail(title: history.bpi?.uSD?.code, subtype: history.bpi?.uSD?.rate),
                    dataDetail(title: history.bpi?.gBP?.code, subtype: history.bpi?.gBP?.rate),
                    dataDetail(title: history.bpi?.eUR?.code, subtype: history.bpi?.eUR?.rate),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "ปัจจุบัน",
                      style: TextStyle(fontSize: 16, color: Colors.black , fontWeight: FontWeight.bold),
                    ),
                    dataDetail(title: data.bpi?.uSD?.code, subtype: data.bpi?.uSD?.rate),
                    dataDetail(title: data.bpi?.gBP?.code, subtype: data.bpi?.gBP?.rate),
                    dataDetail(title: data.bpi?.eUR?.code, subtype: data.bpi?.eUR?.rate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dataDetail({String? title, String? subtype}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "เหรียญ $title/BTC",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            ' ราคา $subtype',
            style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<BtcViewModel>();
    super.dispose();
  }
}
