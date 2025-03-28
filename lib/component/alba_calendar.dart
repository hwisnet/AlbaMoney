import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/alba_utils.dart';
import 'package:flutter_project/utils/attend_utils.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class AlbaCalendar extends StatelessWidget {
  Map<int, List<AlbaModel>> albaSchedules;
  List<AttendModel> attendedList;
  CalendarFormat calendarFormat;
  DateTime focusedDate;
  DateTime selectedDate;
  Function(DateTime, DateTime) onDateSelected;

  AlbaCalendar(
      {super.key,
      required this.albaSchedules,
      required this.attendedList,
      required this.calendarFormat,
      required this.focusedDate,
      required this.selectedDate,
      required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      calendarFormat: calendarFormat,
      daysOfWeekHeight: 30,
      focusedDay: focusedDate,
      firstDay: DateTime(DateTime.now().year - 1, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
      onDaySelected: onDateSelected,
      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          titleCentered: true,
          titleTextStyle: w500.copyWith(fontSize: 20)),
      calendarStyle: const CalendarStyle(outsideDaysVisible: false),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: _defaultBuilder,
        outsideBuilder: _defaultBuilder,
        todayBuilder: _defaultBuilder,
        dowBuilder: _dowBuilder,
        selectedBuilder: _selectedBuilder,
      ),
    );
  }

  Widget _defaultBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: Text(
            '${day.day}',
            style: w500,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Builder(builder: (context) {
                bool hasSchedules = AlbaUtils.hasSchedules(albaSchedules, day);
                return hasSchedules
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AttendUtils.isAllAttended(
                                  albaSchedules, attendedList, day)
                              ? main_color
                              : sub_grey_color,
                        ),
                        width: 5,
                        height: 5,
                      )
                    : Container();
              })),
        )
      ],
    );
  }

  Widget _selectedBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: Text(
            '${day.day}',
            style: w700.copyWith(color: main_color),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Builder(builder: (context) {
                bool hasSchedules = AlbaUtils.hasSchedules(albaSchedules, day);
                return hasSchedules
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AttendUtils.isAllAttended(
                                  albaSchedules, attendedList, day)
                              ? main_color
                              : sub_grey_color,
                        ),
                        width: 5,
                        height: 5,
                      )
                    : Container();
              })),
        )
      ],
    );
  }

  Widget _dowBuilder(BuildContext context, DateTime day) {
    return Center(
        child: Text(DataUtils.convertWeekdayToString(day.weekday),
            style:
                w500.copyWith(color: DataUtils.getWeekdayColor(day.weekday))));
  }
}
