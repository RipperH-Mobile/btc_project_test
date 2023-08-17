import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:btc_project/ui/btc_funtion/btc_viewmodel.dart';
import 'package:btc_project/ui/reuse_file/shared_pref.dart';
import 'package:btc_project/ui/reuse_file/textfield_reuse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'btc_history.dart';
import '../di/Injector.dart';
import 'btc_response.dart';

class BtcMain extends StatefulWidget {
  const BtcMain({Key? key}) : super(key: key);

  @override
  State<BtcMain> createState() => _BtcMainState();
}

class _BtcMainState extends State<BtcMain> {
  final controller = Get.put(BtcViewModel(), permanent: true);
  late Future<BtcDetailResponse> futureBTC;
  late Timer timer;

  final TextEditingController usdController = TextEditingController(),
      gbpController = TextEditingController(),
      eurController = TextEditingController();

  final RxBool _showErrorUsd = false.obs;
  final RxBool _showErrorGbp = false.obs;
  final RxBool _showErrorEur = false.obs;
  final RxString _showErrorInsuranceMSG = ''.obs;
  final RxString _showErrorRentalMSG = ''.obs;

  late double usdToBtc = 0;
  late double gbpToBtc = 0;
  late double eurToBtc = 0;
  late BtcDetailResponse data;

  late BtcDetailResponse history;

  @override
  initState() {
    // indata();
    super.initState();
    futureBTC = controller.fetchBTC();
    SharedPref.initialize();
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) {
      setState(() {
        futureBTC = controller.fetchBTC();
      });
      log("IN Fetch $futureBTC");
    });
    // controller.getDetailBtc(context, isLoading: true);
    // controller.btcData.listen((result) {
    //   if(mounted)
    //   log("Data IS : ${result?.data?.toJson()}");
    //   log("Data IS : ${controller.btcData.value?.data?.toJson()}");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BTC TODAY"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                  onTap: () async {
                    if (history.chartName == '') {
                      Fluttertoast.showToast(
                        msg: "คุณไม่มีข้อมูลไว้ดูย้อนหลัง",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM, // location
                        timeInSecForIosWeb: 2, // duration
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BtcHistory(current: data, history: history)),
                      );
                    }
                  },
                  child: Icon(Icons.history)),
            )
          ],
        ),
        body: FutureBuilder<BtcDetailResponse>(
          future: futureBTC,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data!;
              return body(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              msg: "รีเฟรชข้อมูลเป็นปัจจุบันแล้ว",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM, // location
              timeInSecForIosWeb: 2, // duration
            );
            setState(() {
              futureBTC = controller.fetchBTC();
            });

          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              "รีเฟรชข้อมูล",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }

  body(BtcDetailResponse data) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "ข้อมูล ณ เวลา ${data.time?.updated}",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () async {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: "บันทึกเรียบร้อย",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM, // location
                    timeInSecForIosWeb: 2, // duration
                  );
                  Injector().userSession.addCartList(data);
                  history = Injector().userSession.getStoreCart() ?? BtcDetailResponse();
                  log("CHECK DATA ${history.toJson()}");
                },
                child: Text(
                  "เพิ่มไว้ดูย้อนหลัง",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
            dataDetail(title: data.bpi?.uSD?.code, subtype: data.bpi?.uSD?.rate),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: APTextField(
                    title: "",
                    placeholder: "ระบุเงินที่ต้องการแปลง",
                    borderRadius: 10,
                    controller: usdController,
                    fillColor: Colors.white,
                    borderSideColors: _showErrorUsd.value == true ? Colors.red : null,
                    filled: true,
                    hidelabel: true,
                    lengthLimit: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      _showErrorUsd.value = false;
                      _showErrorInsuranceMSG.value = '';
                      setState(() {
                        usdToBtc = int.parse(value) * 0.000035;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Text("${NumberFormat("#,###.####", "en_US").format(usdToBtc)} BTC"),
                ),
              ],
            ),
            dataDetail(title: data.bpi?.gBP?.code, subtype: data.bpi?.gBP?.rate),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: APTextField(
                    title: "",
                    placeholder: "ระบุเงินที่ต้องการแปลง",
                    borderRadius: 10,
                    controller: gbpController,
                    fillColor: Colors.white,
                    borderSideColors: _showErrorGbp.value == true ? Colors.red : null,
                    filled: true,
                    hidelabel: true,
                    lengthLimit: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      _showErrorGbp.value = false;
                      _showErrorInsuranceMSG.value = '';
                      setState(() {
                        gbpToBtc = int.parse(value) * 0.000035;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Text("${NumberFormat("#,###.####", "en_US").format(gbpToBtc)} BTC"),
                ),
              ],
            ),
            dataDetail(title: data.bpi?.eUR?.code, subtype: data.bpi?.eUR?.rate),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: APTextField(
                    title: "",
                    placeholder: "ระบุเงินที่ต้องการแปลง",
                    borderRadius: 10,
                    controller: eurController,
                    fillColor: Colors.white,
                    borderSideColors: _showErrorEur.value == true ? Colors.red : null,
                    filled: true,
                    hidelabel: true,
                    lengthLimit: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      _showErrorEur.value = false;
                      _showErrorInsuranceMSG.value = '';
                      setState(() {
                        eurToBtc = int.parse(value) * 0.000035;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Text("${NumberFormat("#,###.####", "en_US").format(eurToBtc)} BTC"),
                ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "เหรียญ $title/BTC",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            ' ราคา $subtype',
            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
