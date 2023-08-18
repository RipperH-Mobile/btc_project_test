import 'dart:developer';

import 'package:btc_project/ui/btc_funtion/btc_viewmodel.dart';
import 'package:btc_project/ui/reuse_file/textfield_reuse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:prime_numbers/prime_numbers.dart';

import '../reuse_file/validation.dart';

class GeneratePn extends StatefulWidget {
  const GeneratePn({Key? key}) : super(key: key);

  @override
  State<GeneratePn> createState() => _GeneratePnState();
}

class _GeneratePnState extends State<GeneratePn> {
  final TextEditingController pnController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  final RxBool _showError = false.obs;
  final RxString _showErrorMsg = ''.obs;
  final pn = PrimeNumbers();
  late List<int> count = [];

  @override
  initState() {
    // indata();
    super.initState();
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
          title: Text("จำนวนเฉพาะ"),
        ),
        body: Obx(() => body()),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            APTextField(
              title: "",
              placeholder: "ระบุจำนวนที่ต้องการเจน",
              borderRadius: 10,
              controller: pnController,
              fillColor: Colors.white,
              borderSideColors: _showError.value == true ? Colors.red : null,
              filled: true,
              hidelabel: true,
              lengthLimit: 6,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                _showError.value = false;
                _showErrorMsg.value = '';

                Future<void>.delayed(const Duration(milliseconds: 800), () {
                  setState(() {
                    count = pn.generate(int.parse(value));
                    log("count : $count");
                  });
                });
              },
            ),
            Text("ทั้งหมด ${count.length} ตัวเลข" ,style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 5),
              child: GridView.count(
                scrollDirection: Axis.vertical,
                childAspectRatio: 6 / 10,
                crossAxisCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(count.length, (index) {
                  return Text('${count[index]},');
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
