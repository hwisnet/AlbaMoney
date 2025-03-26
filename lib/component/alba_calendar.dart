import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class AlbaCalendar extends StatefulWidget {
  Map<int, List<AlbaModel>> albaSchedules;
  CalendarFormat calendarFormat;
  DateTime focusedDay;
  DateTime selectedDay;
  Function(DateTime, DateTime) onDaySelected;

  AlbaCalendar(
      {super.key,
      required this.albaSchedules,
      required this.calendarFormat,
      required this.focusedDay,
      required this.selectedDay,
      required this.onDaySelected});

  @override
  State<AlbaCalendar> createState() => _AlbaCalendarState();
}

class _AlbaCalendarState extends State<AlbaCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      calendarFormat: widget.calendarFormat,
      daysOfWeekHeight: 30,
      focusedDay: widget.focusedDay,
      firstDay: DateTime.utc(2025, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      onDaySelected: widget.onDaySelected,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
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
                bool hasSchedules = false;
                for (var schedule in widget.albaSchedules[day.weekday] ?? []) {
                  if (day.isAfter(schedule.startDate) ||
                      day.toUtc() ==
                          DateTime.utc(
                              schedule.startDate.year,
                              schedule.startDate.month,
                              schedule.startDate.day)) {
                    hasSchedules = true;
                  }
                }
                return hasSchedules
                    ? Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: main_color,
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
                bool hasSchedules = false;
                for (var schedule in widget.albaSchedules[day.weekday] ?? []) {
                  if (day.isAfter(schedule.startDate) ||
                      day.toUtc() ==
                          DateTime.utc(
                              schedule.startDate.year,
                              schedule.startDate.month,
                              schedule.startDate.day)) {
                    hasSchedules = true;
                  }
                }
                return hasSchedules
                    ? Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: main_color,
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
