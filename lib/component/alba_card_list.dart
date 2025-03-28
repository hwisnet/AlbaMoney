import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_card.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';

class AlbaCardList extends StatefulWidget {
  Map<int, List<AlbaModel>> albaSchedules;
  DateTime selectedDay;

  AlbaCardList({
    super.key,
    required this.albaSchedules,
    required this.selectedDay,
  });

  @override
  State<AlbaCardList> createState() => _AlbaCardListState();
}

class _AlbaCardListState extends State<AlbaCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('일정', style: w500.copyWith(fontSize: 20)),
          SizedBox(height: DataUtils.height * 0.01),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(height: DataUtils.height * 0.01);
            },
            itemCount: widget.albaSchedules[widget.selectedDay.weekday]!.length,
            itemBuilder: (context, index) {
              bool hasSchedules = false;
              for (var schedule
                  in widget.albaSchedules[widget.selectedDay.weekday] ?? []) {
                if (widget.selectedDay.isAfter(schedule.startDate) ||
                    widget.selectedDay.toUtc() ==
                        DateTime.utc(schedule.startDate.year,
                            schedule.startDate.month, schedule.startDate.day)) {
                  hasSchedules = true;
                }
              }
              if (hasSchedules) {
                return AlbaCard(
                  albaModel:
                      widget.albaSchedules[widget.selectedDay.weekday]![index],
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(
                      top: DataUtils.height * 0.025,
                      left: DataUtils.width * 0.05,
                      right: DataUtils.width * 0.05),
                  child: Center(
                      child: Text('오늘은 일정이 없습니다.',
                          style: w700.copyWith(
                              color: sub_grey_color, fontSize: 20))),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
