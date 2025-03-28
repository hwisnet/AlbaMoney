import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_calendar.dart';
import 'package:flutter_project/component/alba_card_list.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/controller/sqflite_controller.dart';
import 'package:flutter_project/page/history_page.dart';
import 'package:flutter_project/page/schedule_page.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: DataUtils.width * 0.05,
              vertical: DataUtils.height * 0.025),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _monthlyPay(),
                SizedBox(height: DataUtils.height * 0.01),
                _monthlyCalendar(),
                // ElevatedButton(
                //     onPressed: () async {
                //       SqfliteController.to.deleteColums();
                //     },
                //     child: const Text('DB 초기화'))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: false,
      title:
          Text('알바머니', style: w900.copyWith(color: main_color, fontSize: 30)),
      actions: [
        Container(
            padding: EdgeInsets.only(right: DataUtils.width * 0.05),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.notifications,
                  color: main_grey_color, size: 30),
            )),
      ],
    );
  }

  Widget _monthlyPay() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5.0,
              color: background_grey_color,
              offset: Offset(0, 5),
              spreadRadius: 0,
            )
          ],
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: DataUtils.width * 0.05,
                vertical: DataUtils.height * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이번 달 예상 월급',
                    style: w500.copyWith(color: sub_grey_color, fontSize: 15)),
                SizedBox(height: DataUtils.height * 0.01),
                Text('0원', style: w700.copyWith(fontSize: 30)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const HistoryPage());
            },
            child: Container(
              alignment: Alignment.center,
              height: DataUtils.height * 0.05,
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: background_grey_color)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Text('내역 확인하기',
                  style: w700.copyWith(color: main_color, fontSize: 15)),
            ),
          )
        ],
      ),
    );
  }

  Widget _monthlyCalendar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5.0,
                  color: background_grey_color,
                  offset: Offset(0, 5),
                  spreadRadius: 0,
                )
              ],
              color: Colors.white),
          child: Column(
            children: [
              // 데이터 로딩
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: DataUtils.height * 0.025),
                child: Column(
                  children: [
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return AlbaCalendar(
                          calendarFormat: CalendarFormat.week,
                          focusedDay: controller.focusedDate.value,
                          selectedDay: controller.selectedDate.value,
                          albaSchedules: controller.albaSchedules.value,
                          onDaySelected: controller.onDaySelected,
                        );
                      }
                    }),
                    SizedBox(height: DataUtils.height * 0.01),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return AlbaCardList(
                            albaSchedules: controller.albaSchedules,
                            selectedDay: controller.selectedDate.value);
                      }
                    }),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SchedulePage(albaList: controller.albaList));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DataUtils.width,
                  height: DataUtils.height * 0.05,
                  decoration: const BoxDecoration(
                      border:
                          Border(top: BorderSide(color: background_grey_color)),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Text('일정 관리하기',
                      style: w700.copyWith(color: main_color, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: DataUtils.height * 0.01),
      ],
    );
  }

  Widget _bottomNavBar() {
    return Obx(() => BottomNavigationBar(
            onTap: (index) {
              controller.bottomNavBarIndex(index);
            },
            backgroundColor: Colors.white,
            currentIndex: controller.bottomNavBarIndex.value,
            elevation: 1,
            selectedItemColor: main_color,
            unselectedItemColor: sub_grey_color,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '커뮤니티')
            ]));
  }
}
