import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/controller/alba_add_controller.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AlbaAddPage extends GetView<AlbaAddController> {
  AlbaAddPage({super.key});

  List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  Widget selectDateCalendar() {
    return TableCalendar(
      focusedDay: controller.selectedDate.value,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      locale: 'ko_KR',
      daysOfWeekHeight: DataUtils.height * 0.05,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(controller.selectedDate.value, selectedDay)) {
          controller.selectedDate.value = selectedDay;
        }
      },
      selectedDayPredicate: (selectedDay) {
        return isSameDay(controller.selectedDate.value, selectedDay);
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
      time: controller.startTime.value,
      is24HourMode: false,
      isForce2Digits: true,
      itemHeight: 60,
      spacing: 5,
      onTimeChange: (selectedTime) {
        controller.startTime.value = selectedTime;
      },
    );
  }

  Widget selectEndTimeSpinner() {
    return TimePickerSpinner(
      time: controller.endTime.value,
      is24HourMode: false,
      isForce2Digits: true,
      itemHeight: 60,
      spacing: 5,
      onTimeChange: (selectedTime) {
        controller.endTime.value = selectedTime;
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
              SizedBox(height: DataUtils.height * 0.05),
              _calculateButton(),
              SizedBox(height: DataUtils.height * 0.01),
              _description(),
              Divider(height: DataUtils.height * 0.05),
              _calculateResult(),
              Obx(() => Text(DataUtils.calculateMonthlyPay(
                      controller.startTime.value,
                      controller.endTime.value,
                      controller.albaDays,
                      controller.albaPay.value.text,
                      controller.breakTime.value.text,
                      controller.holidayPay.value)
                  .toString()))
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
            Get.delete<AlbaAddController>();
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
          Text('근무지', style: w500.copyWith(fontSize: 15)),
          Container(
              width: DataUtils.width * 0.45,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: controller.albaPlace.value,
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
          Text('근무 시작 날짜', style: w500.copyWith(fontSize: 15)),
          GestureDetector(
            onTap: () => controller.onEditToggle('startDate'),
            child: Container(
              width: DataUtils.width * 0.45,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Obx(() => Text(
                      DataUtils.dateFormatter(controller.selectedDate.value),
                      style: w500.copyWith(fontSize: 15)))),
            ),
          )
        ]),
        Obx(() => _animatedWidget(
            toggle: controller.toggle['startDate']!,
            childWidget: selectDateCalendar()))
      ],
    );
  }

  Widget _albaStartTime() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('근무 시작 시간', style: w500.copyWith(fontSize: 15)),
          GestureDetector(
            onTap: () => controller.onEditToggle('startTime'),
            child: Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Obx(() => Text(
                      DataUtils.timeFormatter(controller.startTime.value),
                      style: w500.copyWith(fontSize: 15)))),
            ),
          )
        ]),
        Obx(() => _animatedWidget(
            toggle: controller.toggle['startTime']!,
            childWidget: selectStartTimeSpinner()))
      ],
    );
  }

  Widget _albaEndTime() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('근무 종료 시간', style: w500.copyWith(fontSize: 15)),
          GestureDetector(
            onTap: () => controller.onEditToggle('endTime'),
            child: Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Obx(() => Text(
                      DataUtils.timeFormatter(controller.endTime.value),
                      style: w500.copyWith(fontSize: 15)))),
            ),
          )
        ]),
        Obx(() => _animatedWidget(
            toggle: controller.toggle['endTime']!,
            childWidget: selectEndTimeSpinner()))
      ],
    );
  }

  Widget _albaDays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('근무 요일', style: w500.copyWith(fontSize: 15)),
        SizedBox(height: DataUtils.height * 0.01),
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, crossAxisSpacing: 7),
            itemCount: weekdays.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (controller.albaDays.contains(weekdays[index])) {
                    controller.albaDays.remove(weekdays[index]);
                  } else {
                    controller.albaDays.add(weekdays[index]);
                  }
                },
                child: Obx(() => Container(
                    decoration: BoxDecoration(
                      color: controller.albaDays.contains(weekdays[index])
                          ? main_color
                          : Colors.white,
                      border: Border.all(
                          color: controller.albaDays.contains(weekdays[index])
                              ? Colors.white
                              : main_color),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Center(
                        child: Text(weekdays[index],
                            style: w500.copyWith(
                                fontSize: 15,
                                color: controller.albaDays
                                        .contains(weekdays[index])
                                    ? Colors.white
                                    : Colors.black))))),
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
          Text('시급', style: w500.copyWith(fontSize: 15)),
          Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: controller.albaPay.value,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: controller.onAlbaPayChanged,
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
          Text('일일 휴식 시간', style: w500.copyWith(fontSize: 15)),
          Container(
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: controller.breakTime.value,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  onChanged: controller.onBreakTimeChanged,
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
          Text('주휴 수당', style: w500.copyWith(fontSize: 15)),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.holidayPay(false),
                child: Obx(
                  () => Container(
                      width: DataUtils.width * 0.22,
                      height: DataUtils.height * 0.045,
                      decoration: BoxDecoration(
                        border: Border.all(color: main_color),
                        borderRadius: BorderRadius.circular(5),
                        color: controller.holidayPay.value
                            ? Colors.white
                            : main_color,
                      ),
                      child: Center(
                          child: Text('미포함',
                              style: w500.copyWith(
                                  color: controller.holidayPay.value
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 15)))),
                ),
              ),
              SizedBox(width: DataUtils.width * 0.01),
              GestureDetector(
                onTap: () => controller.holidayPay(true),
                child: Obx(
                  () => Container(
                      width: DataUtils.width * 0.22,
                      height: DataUtils.height * 0.045,
                      decoration: BoxDecoration(
                        border: Border.all(color: main_color),
                        borderRadius: BorderRadius.circular(5),
                        color: controller.holidayPay.value
                            ? main_color
                            : Colors.white,
                      ),
                      child: Center(
                          child: Text('포함',
                              style: w500.copyWith(
                                  color: controller.holidayPay.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15)))),
                ),
              ),
            ],
          )
        ]),
      ],
    );
  }

  Widget _calculateButton() {
    return GestureDetector(
      onTap: () {
        // final albaModel = AlbaModel(
        //     albaPlace: '파티스',
        //     albaDays: '',
        //     startDate: selectedDate,
        //     startTime: selectedStartTime,
        //     endTime: selectedEndTime,
        //     hourlyRate: 10000);

        // albaModel.albaDayList = selectedDays;

        // await SqfliteRepository.createAlbaData(albaModel);

        // Get.back(result: true);
      },
      child: Container(
          width: DataUtils.width,
          height: DataUtils.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: main_color,
          ),
          child: Center(
              child: Text('예상 월급 계산',
                  style: w700.copyWith(color: Colors.white, fontSize: 15)))),
    );
  }

  Widget _animatedWidget({required bool toggle, required Widget childWidget}) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      child: toggle
          ? Column(
              children: [
                childWidget,
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _description() {
    return Column(
      children: [
        Text(
          '• 한 달은 4.34주 기준으로 월급이 계산됩니다.',
          style: description.copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget _calculateResult() {
    return Obx(() => Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('예상 월급'),
              Text(controller.albaPay.value.text),
              Text(DataUtils.calculateMonthlyPay(
                      controller.startTime.value,
                      controller.endTime.value,
                      controller.albaDays,
                      controller.albaPay.value.text,
                      controller.breakTime.value.text,
                      controller.holidayPay.value)
                  .toString())
            ],
          ),
          const Text('예상 주휴 수당'),
          const Text('합산산 예상 월급'),
        ]));
  }
}
