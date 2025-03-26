import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AlbaSpinner extends StatelessWidget {
  DateTime time;
  Function(DateTime) onTimeChanged;

  AlbaSpinner({
    super.key,
    required this.time,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TimePickerSpinner(
      time: time,
      is24HourMode: false,
      isForce2Digits: true,
      itemHeight: 60,
      spacing: 5,
      onTimeChange: onTimeChanged,
    );
  }
}
