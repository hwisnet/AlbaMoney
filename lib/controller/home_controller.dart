import 'package:flutter/material.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/repository/sqflite_repository.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<Size> calendarHeaderSize = Size.zero.obs;
  Rx<Size> calendarSize = Size.zero.obs;

  DateTime currentDay = DateTime.now().toUtc();
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  RxList<AlbaModel> albaList = <AlbaModel>[].obs;
  RxMap<int, List<AlbaModel>> albaSchedules = <int, List<AlbaModel>>{
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
    7: [],
  }.obs;

  @override
  void onInit() {
    super.onInit();
    initAlbaList();
  }

  Future<void> initAlbaList() async {
    albaList(await SqfliteRepository.readAlbaData());

    for (var alba in albaList) {
      for (var day in alba.albaDayList) {
        albaSchedules[DataUtils.converStringToWeekday(day)]?.add(alba);
      }
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.focusedDay(focusedDay);
    this.selectedDay(selectedDay);
  }
}
