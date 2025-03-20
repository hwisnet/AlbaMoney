import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_calendar.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends GetView<HomeController> {
  Map<int, List<AlbaModel>> albaSchedules;

  HistoryPage({
    super.key,
    required this.albaSchedules,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => AlbaCalendar(
              calendarFormat: CalendarFormat.month,
              focusedDay: controller.focusedDay.value,
              selectedDay: controller.selectedDay.value,
              albaSchedules: controller.albaSchedules,
              onDaySelected: controller.onDaySelected)),
          SizedBox(height: DataUtils.height * 0.025),
          _historyList(),
        ],
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('알바 내역', style: w500.copyWith(fontSize: 20)),
    );
  }

  Widget _historyList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('내역', style: w700.copyWith(fontSize: 20)),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: DataUtils.height * 0.01, bottom: DataUtils.height * 0.025),
            itemCount:
                albaSchedules[controller.selectedDay.value.weekday]!.length,
            itemBuilder: (context, index) {
              return _historyCard(
                albaModel:
                    albaSchedules[controller.selectedDay.value.weekday]![index],
              );
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
                return Text('${pay * time}원',
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
