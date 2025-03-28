import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_calendar.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/alba_utils.dart';
import 'package:flutter_project/utils/attend_utils.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends StatelessWidget {
  Map<int, List<AlbaModel>> albaSchedules;
  List<AttendModel> attendedList;
  CalendarFormat calendarFormat;
  DateTime focusedDate;
  DateTime selectedDate;
  Function(DateTime, DateTime) onDateSelected;

  HistoryPage(
      {super.key,
      required this.albaSchedules,
      required this.attendedList,
      required this.calendarFormat,
      required this.focusedDate,
      required this.selectedDate,
      required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AlbaCalendar(
                albaSchedules: albaSchedules,
                attendedList: attendedList,
                calendarFormat: CalendarFormat.month,
                focusedDate: focusedDate,
                selectedDate: selectedDate,
                onDateSelected: onDateSelected),
            SizedBox(height: DataUtils.height * 0.025),
            Obx(() => _historyList(attendedList)),
          ],
        ),
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('알바 내역', style: w500.copyWith(fontSize: 20)),
    );
  }

  Widget _historyList(List<AttendModel> attendedList) {
    var list = AttendUtils.findByCurrentDate(attendedList, selectedDate);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('내역', style: w500.copyWith(fontSize: 20)),
              SizedBox(width: DataUtils.width * 0.01),
              const Icon(Icons.help_outline_outlined,
                  color: sub_grey_color, size: 25),
            ],
          ),
          SizedBox(height: DataUtils.height * 0.01),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _historyCard(
                  albaModel: AlbaUtils.getAlbaModelById(
                      albaSchedules[selectedDate.weekday] ?? [],
                      list[index].attendId));
            },
          ),
        ],
      ),
    );
  }

  Widget _historyCard({required AlbaModel albaModel}) {
    return Container(
      height: DataUtils.height * 0.1,
      decoration: BoxDecoration(
          border: Border.all(color: background_grey_color),
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                albaModel.albaPlace,
                style: w700.copyWith(fontSize: 25),
              ),
              Builder(builder: (context) {
                final pay = albaModel.albaPay;
                final time =
                    albaModel.endTime.difference(albaModel.startTime).inHours;
                return Text('${int.parse(pay) * time}원',
                    style: w500.copyWith(fontSize: 25));
              })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('시급: ${albaModel.albaPay}원',
                  style: w300.copyWith(fontSize: 15)),
              Row(
                children: [
                  Text('근무 시간:', style: w300.copyWith(fontSize: 15)),
                  SizedBox(width: DataUtils.width * 0.01),
                  Text(
                      '${albaModel.endTime.difference(albaModel.startTime).inMinutes ~/ 60}시간',
                      style: w300.copyWith(fontSize: 15)),
                  SizedBox(width: DataUtils.width * 0.01),
                  Text(
                      '${albaModel.endTime.difference(albaModel.startTime).inMinutes % 60}분',
                      style: w300.copyWith(fontSize: 15)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
