import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DataUtils {
  static final width = Get.width;
  static final height = Get.height;

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static DateTime getDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static Color getWeekdayColor(int weekday) {
    switch (weekday) {
      case 1:
        return Colors.black;
      case 2:
        return Colors.black;
      case 3:
        return Colors.black;
      case 4:
        return Colors.black;
      case 5:
        return Colors.black;
      case 6:
        return Colors.blue;
      case 7:
        return Colors.red;
    }
    return Colors.black;
  }

  static String convertWeekdayToString(int weekday) {
    switch (weekday) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
    }
    return '';
  }

  static int converStringToWeekday(String weekday) {
    switch (weekday) {
      case '월':
        return 1;
      case '화':
        return 2;
      case '수':
        return 3;
      case '목':
        return 4;
      case '금':
        return 5;
      case '토':
        return 6;
      case '일':
        return 7;
    }
    return 0;
  }

  static List<String> sortWeekdays(List<String> weekdays) {
    List<String> order = ['일', '월', '화', '수', '목', '금', '토'];

    weekdays.sort((a, b) => order.indexOf(a).compareTo(order.indexOf(b)));

    return weekdays;
  }

  static DateTime getFirstDateOfCurrentWeek(DateTime currentDay) {
    final year = currentDay.year;
    final month = currentDay.month;
    final day = currentDay.day;

    switch (currentDay.weekday) {
      case 1:
        return DateTime.utc(year, month, day - 1);
      case 2:
        return DateTime.utc(year, month, day - 2);
      case 3:
        return DateTime.utc(year, month, day - 3);
      case 4:
        return DateTime.utc(year, month, day - 4);
      case 5:
        return DateTime.utc(year, month, day - 5);
      case 6:
        return DateTime.utc(year, month, day - 6);
      case 7:
        return DateTime.utc(year, month, day);
    }
    return DateTime.utc(year, month, day);
  }

  static DateTime getLastDateOfCurrentWeek(DateTime currentDay) {
    final year = currentDay.year;
    final month = currentDay.month;
    final day = currentDay.day;

    switch (currentDay.weekday) {
      case 1:
        return DateTime.utc(year, month, day + 5);
      case 2:
        return DateTime.utc(year, month, day + 4);
      case 3:
        return DateTime.utc(year, month, day + 3);
      case 4:
        return DateTime.utc(year, month, day + 2);
      case 5:
        return DateTime.utc(year, month, day + 1);
      case 6:
        return DateTime.utc(year, month, day);
      case 7:
        return DateTime.utc(year, month, day + 6);
    }
    return DateTime.utc(year, month, day);
  }

  static DateTime getFirstDay(DateTime today) {
    final firstDay = today.copyWith(day: 1);

    return firstDay;
  }

  static DateTime getLastDay(DateTime today) {
    final lastDay = today
        .copyWith(month: today.month + 1, day: 1)
        .subtract(const Duration(days: 1));
    return lastDay;
  }

  static String dateFormatter(DateTime date) {
    return DateFormat('yy년 MM월 dd일 E요일', 'ko-kr').format(date);
  }

  static String timeFormatter(DateTime time) {
    return DateFormat('a HH:mm').format(time);
  }

  static int calculateMonthlyPay(DateTime startTime, DateTime endTime,
      List<String> albaDays, String albaPay, String breakTime) {
    int _albaPay = int.parse(albaPay);
    int _breakTime = int.parse(breakTime);
    var difference = endTime
        .copyWith(
          second: 0,
          millisecond: 0,
          microsecond: 0,
        )
        .difference(startTime.copyWith(
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ));
    var time = difference.inMinutes - _breakTime;

    return ((time / 60) * albaDays.length * _albaPay * 4.34).toInt();
  }

  static int calculatHolidayPay(DateTime startTime, DateTime endTime,
      List<String> albaDays, String albaPay, String breakTime, int holidayPay) {
    int _albaPay = int.parse(albaPay);
    int _breakTime = int.parse(breakTime);
    var difference = endTime
        .copyWith(
          second: 0,
          millisecond: 0,
          microsecond: 0,
        )
        .difference(startTime.copyWith(
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ));
    var time = difference.inMinutes - _breakTime;

    if (holidayPay == 0) {
      return 0;
    }

    return (((time / 60) * albaDays.length / 40) * 8 * _albaPay * 4.34).toInt();
  }
}
