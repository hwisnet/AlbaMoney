import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/component/alba_calendar.dart';
import 'package:flutter_project/component/alba_card_list.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: DataUtils.width * 0.05,
              vertical: DataUtils.height * 0.025),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                SizedBox(height: DataUtils.height * 0.025),
                _monthlyPay(),
                SizedBox(height: DataUtils.height * 0.025),
                _monthlyCalendar(),
                SizedBox(height: DataUtils.height * 0.025),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bottomNavBar() {
    final items = [
      const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: main_color,
          ),
          icon: Icon(Icons.home, color: sub_grey_color),
          label: '홈'),
      const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: main_color,
          ),
          icon: Icon(Icons.person, color: sub_grey_color),
          label: '커뮤니티')
    ];

    return Obx(() => BottomNavigationBar(
        onTap: (index) {
          controller.bottomNavBarIndex(index);
        },
        currentIndex: controller.bottomNavBarIndex.value,
        items: items));
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('알바머니', style: w900.copyWith(color: main_color, fontSize: 30)),
        const Icon(Icons.notifications, color: main_grey_color, size: 30),
      ],
    );
  }

  Widget _monthlyPay() {
    return Container(
      width: DataUtils.width,
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
          Container(
            alignment: Alignment.center,
            width: DataUtils.width,
            height: DataUtils.height * 0.05,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: background_grey_color)),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Text('내역 확인하기',
                style: w700.copyWith(color: main_color, fontSize: 15)),
          )
        ],
      ),
    );
  }

  Widget _monthlyCalendar() {
    return Container(
      width: DataUtils.width,
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
          Obx(() => AlbaCalendar(
                albaList: controller.albaList.value,
                albaSchedules: controller.albaSchedules.value,
                focusedDay: controller.focusedDay.value,
                selectedDay: controller.selectedDay.value,
                onDaySelected: controller.onDaySelected,
              )),
          SizedBox(height: DataUtils.height * 0.025),
          Obx(() => AlbaCardList(
                albaSchedules: controller.albaSchedules.value,
                selectedDay: controller.selectedDay.value,
              )),
          Container(
            alignment: Alignment.center,
            width: DataUtils.width,
            height: DataUtils.height * 0.05,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: background_grey_color)),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Text('일정 관리하기',
                style: w700.copyWith(color: main_color, fontSize: 15)),
          )
        ],
      ),
    );
  }
}
