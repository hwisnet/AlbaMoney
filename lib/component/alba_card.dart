import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/repository/sqflite_repository.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AlbaCard extends GetView<HomeController> {
  AlbaModel albaModel;

  AlbaCard({
    super.key,
    required this.albaModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DataUtils.width * 0.05,
          vertical: DataUtils.height * 0.025),
      decoration: BoxDecoration(
          border: Border.all(color: background_grey_color),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('HH:mm').format(albaModel.startTime),
                    style: w500.copyWith(fontSize: 15),
                  ),
                  SizedBox(width: DataUtils.width * 0.01),
                  Text(
                    '-',
                    style: w500.copyWith(fontSize: 15),
                  ),
                  SizedBox(width: DataUtils.width * 0.01),
                  Text(
                    DateFormat('HH:mm').format(albaModel.endTime),
                    style: w500.copyWith(fontSize: 15),
                  ),
                ],
              ),
              Text(
                albaModel.albaPlace,
                style: w700.copyWith(fontSize: 25),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              final isAttended = controller.attendList.where((element) =>
                  element.attendId == albaModel.id &&
                  isSameDay(element.attendDate.toUtc(),
                      controller.selectedDate.value.toUtc()));

              if (isAttended.isNotEmpty) {
                await SqfliteRepository.deleteAttendData(albaModel.id!,
                    controller.selectedDate.value.toUtc().toIso8601String());
                await HomeController.to.refreshController();
              } else {
                await SqfliteRepository.insertAttendData(AttendModel(
                    attendId: albaModel.id!,
                    attendDate: controller.selectedDate.value.toUtc()));
                await HomeController.to.refreshController();
              }
            },
            child: Builder(builder: (context) {
              final isAttended = controller.attendList.where((element) =>
                  element.attendId == albaModel.id &&
                  isSameDay(element.attendDate.toUtc(),
                      controller.selectedDate.value.toUtc()));
              return Icon(Icons.check_circle_outline_rounded,
                  color: isAttended.isNotEmpty ? main_color : sub_grey_color,
                  size: DataUtils.width * 0.1);
            }),
          )
        ],
      ),
    );
  }
}
