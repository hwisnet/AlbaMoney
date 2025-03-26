import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_calendar.dart';
import 'package:flutter_project/component/alba_spinner.dart';
import 'package:flutter_project/controller/alba_add_controller.dart';
import 'package:flutter_project/page/home_page.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wave_divider/wave_divider.dart';

class AlbaAddPage extends GetView<AlbaAddController> {
  AlbaAddPage({super.key});

  List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _albaPlace(),
          SizedBox(height: DataUtils.height * 0.01),
          _albaStartDate(context: context),
          SizedBox(height: DataUtils.height * 0.01),
          _albaStartTime(context: context),
          SizedBox(height: DataUtils.height * 0.01),
          _albaEndTime(context: context),
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
          SizedBox(height: DataUtils.height * 0.05, child: const WaveDivider()),
          _calculateResult(),
        ],
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
      title: Text('근무지 등록', style: w500.copyWith(fontSize: 20)),
      actions: [
        Container(
          padding: EdgeInsets.only(right: DataUtils.width * 0.05),
          child: GestureDetector(
            onTap: () async {
              controller.addAlba();
              Get.delete<AlbaAddController>();
              Get.offAll(() => const HomePage());
            },
            child: Text('등록 완료',
                style: w500.copyWith(color: main_color, fontSize: 15)),
          ),
        )
      ],
    );
  }

  Widget _albaPlace() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('근무지', style: w500.copyWith(fontSize: 15)),
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: DataUtils.width * 0.025),
              width: DataUtils.width * 0.45,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: controller.albaPlace.value,
                  cursorColor: main_color,
                  cursorHeight: DataUtils.height * 0.025,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  style: w500.copyWith(fontSize: 15),
                  onChanged: controller.onAlbaPlaceChanged,
                ),
              ))
        ],
      ),
    );
  }

  Widget _albaStartDate({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('근무 시작 날짜', style: w500.copyWith(fontSize: 15)),
            GestureDetector(
              onTap: () {
                Get.dialog(Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DataUtils.width * 0.05,
                        vertical: DataUtils.height * 0.01),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => AlbaCalendar(
                            albaSchedules: const {},
                            calendarFormat: CalendarFormat.month,
                            focusedDay: controller.startDate.value,
                            selectedDay: controller.startDate.value,
                            onDaySelected: controller.onDaySelected)),
                        SizedBox(height: DataUtils.height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('확인',
                                    style: w500.copyWith(
                                        color: main_color, fontSize: 15))),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              },
              child: Container(
                width: DataUtils.width * 0.45,
                height: DataUtils.height * 0.045,
                decoration: BoxDecoration(
                  border: Border.all(color: main_color),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Obx(() => Text(
                        DataUtils.dateFormatter(controller.startDate.value),
                        style: w500.copyWith(fontSize: 15)))),
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget _albaStartTime({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('근무 시작 시간', style: w500.copyWith(fontSize: 15)),
            GestureDetector(
              onTap: () {
                Get.dialog(Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DataUtils.width * 0.05,
                        vertical: DataUtils.height * 0.01),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => AlbaSpinner(
                            time: controller.startTime.value,
                            onTimeChanged: controller.onStartTimeChanged)),
                        SizedBox(height: DataUtils.height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('확인',
                                    style: w500.copyWith(
                                        color: main_color, fontSize: 15))),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              },
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
        ],
      ),
    );
  }

  Widget _albaEndTime({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('근무 종료 시간', style: w500.copyWith(fontSize: 15)),
            GestureDetector(
              onTap: () {
                Get.dialog(Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DataUtils.width * 0.05,
                        vertical: DataUtils.height * 0.01),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => AlbaSpinner(
                            time: controller.endTime.value,
                            onTimeChanged: controller.onEndTimeChanged)),
                        SizedBox(height: DataUtils.height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('확인',
                                    style: w500.copyWith(
                                        color: main_color, fontSize: 15))),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              },
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
        ],
      ),
    );
  }

  Widget _albaDays() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
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
                                      : sub_grey_color))))),
                );
              }),
        ],
      ),
    );
  }

  Widget _albaPay() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('시급', style: w500.copyWith(fontSize: 15)),
          Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: DataUtils.width * 0.025),
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.albaPay.value,
                        cursorColor: main_color,
                        cursorHeight: DataUtils.height * 0.025,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.end,
                        style: w500.copyWith(fontSize: 15),
                        onChanged: controller.onAlbaPayChanged,
                      ),
                    ),
                    Text('원', style: w500.copyWith(fontSize: 15)),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _albaBreakTime() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('일일 휴식 시간', style: w500.copyWith(fontSize: 15)),
          Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: DataUtils.width * 0.025),
              width: DataUtils.width * 0.22,
              height: DataUtils.height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.breakTime.value,
                        cursorColor: main_color,
                        cursorHeight: DataUtils.height * 0.025,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.end,
                        style: w500.copyWith(fontSize: 15),
                        onChanged: controller.onBreakTimeChanged,
                      ),
                    ),
                    Text('분', style: w500.copyWith(fontSize: 15)),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _albaHolidayPay() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('주휴 수당', style: w500.copyWith(fontSize: 15)),
            Row(
              children: [
                GestureDetector(
                  onTap: () => controller.holidayPay(0),
                  child: Obx(
                    () => Container(
                        width: DataUtils.width * 0.22,
                        height: DataUtils.height * 0.045,
                        decoration: BoxDecoration(
                          border: Border.all(color: main_color),
                          borderRadius: BorderRadius.circular(5),
                          color: controller.holidayPay.value == 1
                              ? Colors.white
                              : main_color,
                        ),
                        child: Center(
                            child: Text('미포함',
                                style: w500.copyWith(
                                    color: controller.holidayPay.value == 1
                                        ? sub_grey_color
                                        : Colors.white,
                                    fontSize: 15)))),
                  ),
                ),
                SizedBox(width: DataUtils.width * 0.01),
                GestureDetector(
                  onTap: () => controller.holidayPay(1),
                  child: Obx(
                    () => Container(
                        width: DataUtils.width * 0.22,
                        height: DataUtils.height * 0.045,
                        decoration: BoxDecoration(
                          border: Border.all(color: main_color),
                          borderRadius: BorderRadius.circular(5),
                          color: controller.holidayPay.value == 1
                              ? main_color
                              : Colors.white,
                        ),
                        child: Center(
                            child: Text('포함',
                                style: w500.copyWith(
                                    color: controller.holidayPay.value == 1
                                        ? Colors.white
                                        : sub_grey_color,
                                    fontSize: 15)))),
                  ),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }

  Widget _calculateButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: GestureDetector(
        onTap: controller.calculate,
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
      ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Column(
        children: [
          Text(
            '• 한 달은 4.34주 기준으로 월급이 계산됩니다.',
            style: w500.copyWith(color: sub_grey_color, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _calculateResult() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Obx(() => Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('예상 월급', style: w500.copyWith(fontSize: 15)),
                Text(
                    '${NumberFormat('###,###,###,###').format(controller.monthlyPayResult.value)}원',
                    style: w500.copyWith(fontSize: 15)),
              ],
            ),
            SizedBox(height: DataUtils.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('예상 주휴 수당', style: w500.copyWith(fontSize: 15)),
                Text(
                    '${NumberFormat('###,###,###,###').format(controller.holidayPayResult.value)}원',
                    style: w500.copyWith(fontSize: 15)),
              ],
            ),
            Divider(height: DataUtils.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    '총 ${NumberFormat('###,###,###,###').format(controller.totalResult.value)}원',
                    style: w500.copyWith(fontSize: 30)),
              ],
            ),
          ])),
    );
  }
}
