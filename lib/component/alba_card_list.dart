import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_card.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/model/attendance_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/alba_utils.dart';
import 'package:flutter_project/utils/data_utils.dart';

class AlbaCardList extends StatelessWidget {
  Map<int, List<AlbaModel>> albaSchedules;
  List<AttendModel> attendedList;
  DateTime selectedDate;

  AlbaCardList({
    super.key,
    required this.albaSchedules,
    required this.attendedList,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('출근', style: w500.copyWith(fontSize: 20)),
          SizedBox(height: DataUtils.height * 0.01),
          _albaCardWidget(),
          SizedBox(height: DataUtils.height * 0.1),
          Text('퇴근', style: w500.copyWith(fontSize: 20)),
          SizedBox(height: DataUtils.height * 0.01),
        ],
      ),
    );
  }

  Widget _albaCardWidget() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(height: DataUtils.height * 0.01);
      },
      itemCount: albaSchedules[selectedDate.weekday]!.length,
      itemBuilder: (context, index) {
        bool hasSchedules = AlbaUtils.hasSchedules(albaSchedules, selectedDate);
        if (hasSchedules) {
          return AlbaCard(
            albaModel: albaSchedules[selectedDate.weekday]![index],
            attendedList: attendedList,
            selectedDate: selectedDate,
          );
        } else {
          return _emptyCardWidget();
        }
      },
    );
  }

  Widget _emptyCardWidget() {
    return Container(
      padding: EdgeInsets.only(
          top: DataUtils.height * 0.025,
          left: DataUtils.width * 0.05,
          right: DataUtils.width * 0.05),
      child: Center(
          child: Text('오늘은 일정이 없습니다.',
              style: w700.copyWith(color: sub_grey_color, fontSize: 20))),
    );
  }
}
