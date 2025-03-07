import 'package:flutter/material.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:table_calendar/table_calendar.dart';

class AlbaCalendar extends StatefulWidget {
  List<AlbaModel> albaList;
  Map<int, List<AlbaModel>> albaSchedules;
  DateTime focusedDay;
  DateTime selectedDay;
  Function(DateTime, DateTime) onDaySelected;

  AlbaCalendar(
      {super.key,
      required this.albaList,
      required this.albaSchedules,
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
      calendarFormat: CalendarFormat.week,
      daysOfWeekHeight: 30,
      focusedDay: widget.focusedDay,
      firstDay: DateTime.utc(2025, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      onDaySelected: widget.onDaySelected,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: _defaultBuilder,
        selectedBuilder: _selectedBuilder,
        todayBuilder: _defaultBuilder,
        outsideBuilder: _defaultBuilder,
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
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: widget.albaSchedules[day.weekday]!.isNotEmpty
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      width: 5,
                      height: 5,
                    )
                  : Container()),
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
            style: const TextStyle(color: Colors.red),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: widget.albaSchedules[day.weekday]!.isNotEmpty
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      width: 5,
                      height: 5,
                    )
                  : Container()),
        )
      ],
    );
  }
}
