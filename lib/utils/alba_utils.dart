import 'package:flutter_project/model/alba_model.dart';

class AlbaUtils {
  static bool hasSchedules(
      Map<int, List<AlbaModel>> schedules, DateTime selectedDate) {
    for (AlbaModel schedule in schedules[selectedDate.weekday] ?? []) {
      DateTime selected =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      DateTime start = DateTime(schedule.startDate.year,
          schedule.startDate.month, schedule.startDate.day);
      if (selected.compareTo(start) >= 0) {
        return true;
      }
    }
    return false;
  }

  static AlbaModel getAlbaModelById(List<AlbaModel> albaModelList, int id) {
    return albaModelList.firstWhere((albaModel) => albaModel.id == id);
  }
}
