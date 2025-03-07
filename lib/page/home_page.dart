import 'package:flutter/material.dart';
import 'package:flutter_project/component/alba_calendar.dart';
import 'package:flutter_project/component/alba_card.dart';
import 'package:flutter_project/component/alba_list.dart';
import 'package:flutter_project/controller/alba_add_controller.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/page/alba_add_page.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SlidingUpPanel(
            minHeight: 500,
            maxHeight: DataUtils.height * 0.7,
            panel: Column(
              children: [
                Obx(() => AlbaCalendar(
                      albaList: controller.albaList.value,
                      albaSchedules: controller.albaSchedules.value,
                      focusedDay: controller.focusedDay.value,
                      selectedDay: controller.selectedDay.value,
                      onDaySelected: controller.onDaySelected,
                    )),
                SizedBox(height: DataUtils.height * 0.01),
                _addAlbaButton(),
                SizedBox(height: DataUtils.height * 0.01),
                Obx(() => AlbaList(
                      albaList: controller.albaList.value,
                      albaSchedules: controller.albaSchedules.value,
                      focusedDay: controller.focusedDay.value,
                      selectedDay: controller.selectedDay.value,
                      onDaySelected: controller.onDaySelected,
                    )),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.notifications_outlined, size: 25),
                      Icon(Icons.settings_outlined, size: 25),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('예상 월급',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10.0),
                      Builder(builder: (context) {
                        final today = controller.currentDay;
                        final firstDay = DataUtils.getFirstDay(today);
                        final lastDay = DataUtils.getLastDay(today);
                        return Text(
                          '(${firstDay.month}월 ${firstDay.day}일 ~ ${lastDay.month}월 ${lastDay.day}일)',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                        );
                      })
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('0원',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _addAlbaButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              Get.put(AlbaAddController());
              Get.to(() => AlbaAddPage());
            },
            child:
                const Text('+ 알바 등록하기', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
