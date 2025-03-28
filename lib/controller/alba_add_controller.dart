import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/repository/sqflite_repository.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';

class AlbaAddController extends GetxController {
  Rx<TextEditingController> albaPlace = TextEditingController().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> startTime = DateTime.now().copyWith(hour: 0, minute: 0).obs;
  Rx<DateTime> endTime = DateTime.now().copyWith(hour: 12, minute: 0).obs;
  RxList<String> albaDays = <String>[].obs;
  Rx<TextEditingController> albaPay = TextEditingController().obs;
  Rx<TextEditingController> breakTime = TextEditingController().obs;
  Rx<int> holidayPay = 1.obs;

  Rx<int> monthlyPayResult = 0.obs;
  Rx<int> holidayPayResult = 0.obs;
  Rx<int> totalResult = 0.obs;

  RxMap<String, bool> toggle = <String, bool>{
    'startDate': false,
    'startTime': false,
    'endTime': false,
  }.obs;

  Future<void> addAlba() async {
    if (albaPay.value.text.isNotEmpty &&
        albaDays.isNotEmpty &&
        albaPay.value.text.isNotEmpty &&
        breakTime.value.text.isNotEmpty) {
      SqfliteRepository.insertAlbaData(AlbaModel(
          albaPlace: albaPlace.value.text,
          albaDays: albaDays.join(','),
          startDate: startDate.value,
          startTime: startTime.value,
          endTime: endTime.value,
          albaPay: albaPay.value.text,
          breakTime: breakTime.value.text,
          holidayPay: holidayPay.value));
      await HomeController.to.refreshController();
    } else {
      Get.dialog(Dialog(
        child: Container(
            height: DataUtils.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('필수 항목이 입력되지 않았습니다.', style: w700.copyWith(fontSize: 15)),
                SizedBox(height: DataUtils.height * 0.015),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: DataUtils.width * 0.22,
                    height: DataUtils.height * 0.045,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: main_color),
                    child: Center(
                        child: Text('확인',
                            style: w500.copyWith(
                                color: Colors.white, fontSize: 15))),
                  ),
                )
              ],
            )),
      ));
    }
  }

  void calculate() {
    if (albaPay.value.text.isEmpty || breakTime.value.text.isEmpty) {
      Get.dialog(Dialog(
        child: Container(
            height: DataUtils.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('필수 항목이 입력되지 않았습니다.', style: w700.copyWith(fontSize: 15)),
                SizedBox(height: DataUtils.height * 0.015),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: DataUtils.width * 0.22,
                    height: DataUtils.height * 0.045,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: main_color),
                    child: Center(
                        child: Text('확인',
                            style: w500.copyWith(
                                color: Colors.white, fontSize: 15))),
                  ),
                )
              ],
            )),
      ));
    } else {
      // 월급 계산
      monthlyPayResult.value = DataUtils.calculateMonthlyPay(startTime.value,
          endTime.value, albaDays, albaPay.value.text, breakTime.value.text);
      // 주휴 수당 계산
      holidayPayResult.value = DataUtils.calculatHolidayPay(
          startTime.value,
          endTime.value,
          albaDays,
          albaPay.value.text,
          breakTime.value.text,
          holidayPay.value);
      // 총 계산
      totalResult.value = monthlyPayResult.value + holidayPayResult.value;
      update();
    }
  }

  void onEditToggle(String keyValue) {
    for (var key in toggle.keys) {
      if (key == keyValue) {
        toggle[key] = !toggle[key]!;
      } else {
        toggle[key] = false;
      }
    }
  }

  void onAlbaPlaceChanged(String text) {
    albaPlace.value.text = text;
    update();
  }

  void onAlbaPayChanged(String text) {
    albaPay.value.text = text;
    update();
  }

  void onBreakTimeChanged(String text) {
    breakTime.value.text = text;
    update();
  }

  void onStartTimeChanged(DateTime startTime) {
    this.startTime(startTime);
  }

  void onEndTimeChanged(DateTime endTime) {
    this.endTime(endTime);
  }

  void onDaySelected(DateTime startDate, DateTime focusedDay) {
    this.startDate(startDate);
  }
}
