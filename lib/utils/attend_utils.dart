import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/utils/data_utils.dart';

class AttendUtils {
  static bool isAttended(AlbaModel albaModel, List<AttendModel> attendedList,
      DateTime selectedDate) {
    var isAttended = attendedList
        .where((attended) =>
            attended.attendId == albaModel.id &&
            DataUtils.isSameDay(attended.attendDate, selectedDate))
        .isNotEmpty;

    return isAttended;
  }

  static bool isAllAttended(Map<int, List<AlbaModel>> albaSchedules,
      List<AttendModel> attendedList, DateTime selectedDate) {
    var isAllAttended = true;

    for (AlbaModel schedule in albaSchedules[selectedDate.weekday] ?? []) {
      isAllAttended = attendedList
          .where((attended) =>
              attended.attendId == schedule.id &&
              DataUtils.isSameDay(attended.attendDate, selectedDate))
          .isNotEmpty;
    }

    return isAllAttended;
  }

  static List<AttendModel> findByCurrentDate(
      List<AttendModel> attendedList, DateTime date) {
    var result = attendedList
        .where((attended) => DataUtils.isSameDay(attended.attendDate, date));
    return result.toList();
  }
}
