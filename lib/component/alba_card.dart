import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/repository/sqflite_repository.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/attend_utils.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:intl/intl.dart';

class AlbaCard extends StatelessWidget {
  AlbaModel albaModel;
  List<AttendModel> attendedList;
  DateTime selectedDate;

  AlbaCard({
    super.key,
    required this.albaModel,
    required this.attendedList,
    required this.selectedDate,
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
          Builder(builder: (context) {
            final isAttended =
                AttendUtils.isAttended(albaModel, attendedList, selectedDate);
            return GestureDetector(
                onTap: () async {
                  if (isAttended) {
                    await SqfliteRepository.deleteAttendData(
                        albaModel.id!, selectedDate.toUtc().toIso8601String());
                    await HomeController.to.refreshController();
                  } else {
                    await SqfliteRepository.insertAttendData(AttendModel(
                        attendId: albaModel.id!,
                        attendDate: selectedDate.toUtc()));
                    await HomeController.to.refreshController();
                  }
                },
                child: Icon(Icons.check_circle_outline_rounded,
                    color: isAttended ? main_color : sub_grey_color,
                    size: DataUtils.width * 0.1));
          })
        ],
      ),
    );
  }
}
