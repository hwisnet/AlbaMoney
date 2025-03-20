import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbaAddController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<TextEditingController> albaPlace = TextEditingController().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> startTime = DateTime.now().copyWith(hour: 0, minute: 0).obs;
  Rx<DateTime> endTime = DateTime.now().copyWith(hour: 12, minute: 0).obs;
  RxList<String> albaDays = <String>[].obs;
  Rx<TextEditingController> albaPay = TextEditingController().obs;
  Rx<TextEditingController> breakTime = TextEditingController().obs;
  Rx<bool> holidayPay = true.obs;

  Rx<int> monthlyPayResult = 0.obs;
  Rx<int> holidayPayResult = 0.obs;
  Rx<int> totalResult = 0.obs;

  RxMap<String, bool> toggle = <String, bool>{
    'startDate': false,
    'startTime': false,
    'endTime': false,
  }.obs;

  void onEditToggle(String keyValue) {
    for (var key in toggle.keys) {
      if (key == keyValue) {
        toggle[key] = !toggle[key]!;
      } else {
        toggle[key] = false;
      }
    }
  }

  void onAlbaPayChanged(String text) {
    albaPay.value.text = text;
    update();
  }

  void onBreakTimeChanged(String text) {
    breakTime.value.text = text;
    update();
  }
}
