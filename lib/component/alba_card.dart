import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:intl/intl.dart';

class AlbaCard extends StatelessWidget {
  AlbaModel albaModel;

  AlbaCard({
    super.key,
    required this.albaModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataUtils.height * 0.1,
      decoration: BoxDecoration(
          border: Border.all(color: background_grey_color),
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
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
          Icon(Icons.check_circle_outline_rounded,
              color: sub_grey_color, size: DataUtils.width * 0.1)
        ],
      ),
    );
  }
}
