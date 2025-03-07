import 'package:flutter/material.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:intl/intl.dart';

class AlbaCard extends StatelessWidget {
  AlbaModel albaModel;
  DateTime selectedDay;

  AlbaCard({
    super.key,
    required this.albaModel,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              value: false,
              onChanged: (value) {}),
          const SizedBox(width: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('HH:mm').format(albaModel.startTime),
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  const SizedBox(width: 5.0),
                  const Text(
                    '-',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    DateFormat('HH:mm').format(albaModel.endTime),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              Text(
                albaModel.albaPlace,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
