import 'package:flutter/material.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/repository/sqflite_repository.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<int> bottomNavBarIndex = 0.obs;

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

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initAlbaList();
  }

  Future<void> initAlbaList() async {
    isLoading(true);
    List<AlbaModel> loadedAlbaList = await SqfliteRepository.readAlbaData();
    albaList(loadedAlbaList);

    for (var alba in albaList) {
      for (var day in alba.albaDayList) {
        albaSchedules[DataUtils.converStringToWeekday(day)]?.add(alba);
      }
    }
    isLoading(false);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay(selectedDay);
    this.focusedDay(focusedDay);
  }
}
