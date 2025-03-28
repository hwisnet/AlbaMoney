import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/repository/sqflite_repository.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<int> bottomNavBarIndex = 0.obs;

  DateTime currentDay = DateTime.now().toUtc();
  Rx<DateTime> focusedDate = DateTime.now().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxList<AlbaModel> albaList = <AlbaModel>[].obs;
  RxList<AttendModel> attendList = <AttendModel>[].obs;
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
    refreshController();
  }

  Future<void> refreshController() async {
    isLoading(true);
    List<AlbaModel> loadedAlbaList = await SqfliteRepository.readAlbaData();
    List<AttendModel> loadedAttendList =
        await SqfliteRepository.readAttendData();

    albaList(loadedAlbaList);
    attendList(loadedAttendList);

    Map<int, List<AlbaModel>> tempSchedules = {
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
      6: [],
      7: [],
    };

    for (var alba in albaList) {
      for (var day in alba.albaDayList) {
        tempSchedules[DataUtils.converStringToWeekday(day)]?.add(alba);
      }
    }

    albaSchedules(tempSchedules);
    isLoading(false);
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    this.selectedDate(selectedDate);
    this.focusedDate(focusedDate);
  }
}
