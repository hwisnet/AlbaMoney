import 'package:flutter/material.dart';
import 'package:flutter_project/component/alba_card.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/utils/data_utils.dart';

class AlbaList extends StatefulWidget {
  List<AlbaModel> albaList;
  Map<int, List<AlbaModel>> albaSchedules;
  DateTime focusedDay;
  DateTime selectedDay;
  Function(DateTime, DateTime) onDaySelected;

  AlbaList(
      {super.key,
      required this.albaList,
      required this.albaSchedules,
      required this.focusedDay,
      required this.selectedDay,
      required this.onDaySelected});

  @override
  State<AlbaList> createState() => _AlbaCalendarState();
}

class _AlbaCalendarState extends State<AlbaList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('일정',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.albaSchedules[widget.selectedDay.weekday]!.length,
            itemBuilder: (context, index) {
              return AlbaCard(
                albaModel:
                    widget.albaSchedules[widget.selectedDay.weekday]![index],
                selectedDay: widget.selectedDay,
              );
            },
          ),
        ],
      ),
    );
  }
}
