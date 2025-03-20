import 'package:flutter/material.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AlbaEditPage extends StatefulWidget {
  AlbaModel albaModel;

  AlbaEditPage({super.key, required this.albaModel});

  @override
  State<AlbaEditPage> createState() => _AlbaEditPageState();
}

class _AlbaEditPageState extends State<AlbaEditPage> {
  List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  late TextEditingController _albaPlaceController;
  late TextEditingController _albaPayController;
  late TextEditingController _albaBreakTimeController;
  final _holidayPay = true;

  @override
  void initState() {
    super.initState();
    _albaPlaceController =
        TextEditingController(text: widget.albaModel.albaPlace);
    _albaPayController =
        TextEditingController(text: widget.albaModel.albaPay.toString());
    _albaBreakTimeController =
        TextEditingController(text: widget.albaModel.albaBreakTime.toString());
  }

  void update() => setState(() {});

  Widget selectDateCalendar() {
    return TableCalendar(
      focusedDay: widget.albaModel.startDate,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      locale: 'ko_KR',
      daysOfWeekHeight: DataUtils.height * 0.05,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(widget.albaModel.startDate, selectedDay)) {
          widget.albaModel.startDate = selectedDay;
        }
      },
      selectedDayPredicate: (selectedDay) {
        return isSameDay(widget.albaModel.startDate, selectedDay);
      },
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
        outsideDaysVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) {
          return Center(
              child: Text('${day.day}',
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)));
        },
      ),
    );
  }

  Widget selectStartTimeSpinner() {
    return TimePickerSpinner(
      time: widget.albaModel.startTime,
      is24HourMode: false,
      isForce2Digits: true,
      itemHeight: 60,
      spacing: 5,
      onTimeChange: (selectedTime) {
        widget.albaModel.startTime = selectedTime;
      },
    );
  }

  Widget selectEndTimeSpinner() {
    return TimePickerSpinner(
      time: widget.albaModel.endTime,
      is24HourMode: false,
      isForce2Digits: true,
      itemHeight: 60,
      spacing: 5,
      onTimeChange: (selectedTime) {
        widget.albaModel.endTime = selectedTime;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _albaPlace(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaStartDate(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaStartTime(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaEndTime(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaDays(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaPay(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaBreakTime(),
              SizedBox(height: DataUtils.height * 0.01),
              _albaHolidayPay(),
            ],
          ),
        ),
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('근무지 등록',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)));
  }

  Widget _albaPlace() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('근무지'),
          Container(
              width: DataUtils.width * 0.45,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                child: TextField(
                  controller: _albaPlaceController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }

  Widget _albaStartDate() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('근무 시작 날짜'),
          GestureDetector(
            // onTap: () => controller.onEditToggle('startDate'),
            child: Container(
              width: DataUtils.width * 0.45,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                  child: Text(
                      DataUtils.dateFormatter(widget.albaModel.startDate),
                      style: w500)),
            ),
          )
        ]),
        // Obx(() => _animatedWidget(
        //     toggle: controller.toggle['startDate']!,
        //     childWidget: selectDateCalendar()))
      ],
    );
  }

  Widget _albaStartTime() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('근무 시작 시간'),
          GestureDetector(
            // onTap: () => controller.onEditToggle('startTime'),
            child: Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                  child: Text(
                      DataUtils.timeFormatter(widget.albaModel.startTime),
                      style: w500)),
            ),
          )
        ]),
        // Obx(() => _animatedWidget(
        //     toggle: controller.toggle['startTime']!,
        //     childWidget: selectStartTimeSpinner()))
      ],
    );
  }

  Widget _albaEndTime() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('근무 종료 시간'),
          GestureDetector(
            // onTap: () => controller.onEditToggle('endTime'),
            child: Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                  child: Text(DataUtils.timeFormatter(widget.albaModel.endTime),
                      style: w500)),
            ),
          )
        ]),
        // Obx(() => _animatedWidget(
        //     toggle: controller.toggle['endTime']!,
        //     childWidget: selectEndTimeSpinner()))
      ],
    );
  }

  Widget _albaDays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('근무 요일'),
        SizedBox(height: DataUtils.height * 0.01),
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, crossAxisSpacing: 7),
            itemCount: weekdays.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (widget.albaModel.albaDayList.contains(weekdays[index])) {
                    widget.albaModel.albaDayList.remove(weekdays[index]);
                  } else {
                    widget.albaModel.albaDayList.add(weekdays[index]);
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      color:
                          widget.albaModel.albaDayList.contains(weekdays[index])
                              ? Colors.black
                              : Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Center(
                        child: Text(weekdays[index],
                            style: TextStyle(
                                color: widget.albaModel.albaDayList
                                        .contains(weekdays[index])
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14)))),
              );
            }),
      ],
    );
  }

  Widget _albaPay() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('시급'),
          Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                child: TextField(
                  controller: _albaPayController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  // onChanged: controller.onAlbaPayChanged,
                ),
              ))
        ],
      ),
    );
  }

  Widget _albaBreakTime() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('일일 휴식 시간'),
          Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                child: TextField(
                  controller: _albaBreakTimeController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  // onChanged: controller.onBreakTimeChanged,
                ),
              ))
        ],
      ),
    );
  }

  Widget _albaHolidayPay() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('주휴 수당'),
          Row(
            children: [
              GestureDetector(
                // onTap: () => controller.holidayPay(false),
                child: Container(
                    width: DataUtils.width * 0.22,
                    height: DataUtils.height * 0.045,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: _holidayPay
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.black,
                    ),
                    child: Center(
                        child: Text('미포함',
                            style: w500.copyWith(
                                color: _holidayPay
                                    ? Colors.black
                                    : Colors.white)))),
              ),
              SizedBox(width: DataUtils.width * 0.01),
              GestureDetector(
                // onTap: () => controller.holidayPay(true),
                child: Container(
                    width: DataUtils.width * 0.22,
                    height: DataUtils.height * 0.045,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: _holidayPay
                          ? Colors.black
                          : Colors.grey.withOpacity(0.5),
                    ),
                    child: Center(
                        child: Text('포함',
                            style: w500.copyWith(
                                color: _holidayPay
                                    ? Colors.white
                                    : Colors.black)))),
              ),
            ],
          )
        ]),
      ],
    );
  }
}
