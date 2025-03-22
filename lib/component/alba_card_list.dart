import 'package:flutter/material.dart';
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
          Text('일정', style: w700.copyWith(fontSize: 20)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                top: DataUtils.height * 0.01, bottom: DataUtils.height * 0.025),
            itemCount: widget.albaSchedules[widget.selectedDay.weekday]!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  AlbaCard(
                    albaModel: widget
                        .albaSchedules[widget.selectedDay.weekday]![index],
                  ),
                  SizedBox(height: DataUtils.height * 0.01),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
