import 'dart:developer';

import 'package:btc_project/ui/btc_funtion/btc_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../reuse_file/validation.dart';

class PinMain extends StatefulWidget {
  const PinMain({Key? key}) : super(key: key);

  @override
  State<PinMain> createState() => _PinMainState();
}

class _PinMainState extends State<PinMain> {
  final TextEditingController pinccodeController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  final RxBool _showError = false.obs;
  final RxString _showErrorMsg = ''.obs;

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
          title: Text("PIN CODE"),
        ),
        body: Obx(() => body()),
      ),
    );
  }

  body() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40),
                margin: const EdgeInsets.only(top: 10),
                child: PinCodeTextField(
                  appContext: context,
                  controller: pinccodeController,
                  length: 6,
                  cursorColor: Colors.black,
                  animationType: AnimationType.fade,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autoFocus: true,
                  enableActiveFill: true,
                  onChanged: (value) async {
                    // _errorMessage.value = '';
                    final List<String> split = value.split('');
                    if (value.length == 6) {
                      if (value.contains("111") ||
                          value.contains("222") ||
                          value.contains("333") ||
                          value.contains("444") ||
                          value.contains("555") ||
                          value.contains("666") ||
                          value.contains("777") ||
                          value.contains("888") ||
                          value.contains("999") ||
                          value.contains("000")) {
                        _showError.value = true;
                        _showErrorMsg.value = "เลขซ้ำกันมากเกินไป";
                      } else if (value.contains("012") ||
                          value.contains("123") ||
                          value.contains("234") ||
                          value.contains("345") ||
                          value.contains("456") ||
                          value.contains("567") ||
                          value.contains("678") ||
                          value.contains("789") ||
                          value.contains("890")) {
                        _showError.value = true;
                        _showErrorMsg.value = "เลขเรียงกันมากเกินไป";
                      } else if (split[0] == split[1] && split[2] == split[3] && split[4] == split[5] ) {
                        _showError.value = true;
                        _showErrorMsg.value = "เลขซ้ำกันเกิน2ชุด";
                      } else {
                        _showError.value = false;
                        _showErrorMsg.value = "";
                      }
                    } else {
                      _showError.value = true;
                      _showErrorMsg.value = "กรุณากรอกให้ครบ 6 หลัก";
                    }
                  },
                  onCompleted: (v) async {
                    // pinccodeController.clear();
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: Colors.grey.shade200,
                    inactiveFillColor: Colors.grey.shade200,
                    activeColor: Colors.grey.shade200,
                    inactiveColor: Colors.grey.shade200,
                    selectedColor: Colors.grey.shade200,
                    selectedFillColor: Colors.grey.shade200,
                  ),
                ),
              )),
          Visibility(
              visible: _showError.value == true,
              child: Validation(icon: Icons.cancel_rounded, textValidate: _showErrorMsg.value)),
        ],
      ),
    );
  }

  void removeLastCharacter(String? val) {
    List<String>? split = val?.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
    if (split?[0] == split?[1] && split?[0] == split?[2]) {
      _showError.value = true;
      _showErrorMsg.value = "เลขซ้ำกันมากเกินไป";
    } else if (split?[0] == (int.parse(split?[1] ?? '') - 1) && split?[0] == (int.parse(split?[1] ?? '') - 2)) {
      _showError.value = true;
      _showErrorMsg.value = "เลขเรียงกันมากเกินไป";
    }
    if (val?.length == 6) {
    } else {
      pinccodeController.text = val.toString();
    }
  }

  @override
  void dispose() {
    Get.delete<BtcViewModel>();
    super.dispose();
  }
}
