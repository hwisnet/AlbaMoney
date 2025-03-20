import 'package:flutter/material.dart';
import 'package:flutter_project/colors/colors.dart';
import 'package:flutter_project/controller/alba_add_controller.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/model/alba_model.dart';
import 'package:flutter_project/page/alba_add_page.dart';
import 'package:flutter_project/page/alba_edit_page.dart';
import 'package:flutter_project/styles/text_styles.dart';
import 'package:flutter_project/utils/data_utils.dart';
import 'package:get/get.dart';

class SchedulePage extends GetView<HomeController> {
  List<AlbaModel> albaList;

  SchedulePage({
    super.key,
    required this.albaList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DataUtils.width * 0.05,
            vertical: DataUtils.height * 0.025),
        child: _scheduleList(),
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('알바 일정', style: w500.copyWith(fontSize: 20)),
      actions: [
        Container(
            padding: EdgeInsets.only(right: DataUtils.width * 0.05),
            child: GestureDetector(
              onTap: () {
                Get.put(AlbaAddController());
                Get.to(() => AlbaAddPage());
              },
              child: Text('새 알바 등록',
                  style: w500.copyWith(color: main_color, fontSize: 15)),
            ))
      ],
    );
  }

  Widget _scheduleList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('일정', style: w700.copyWith(fontSize: 20)),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: DataUtils.height * 0.01, bottom: DataUtils.height * 0.025),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: DataUtils.height * 0.025,
              crossAxisCount: 1,
              childAspectRatio: 2),
          itemCount: albaList.length,
          itemBuilder: (context, index) {
            return _scheduleCard(
              albaModel: albaList[index],
            );
          },
        ),
      ],
    );
  }

  Widget _scheduleCard({required AlbaModel albaModel}) {
    return Container(
      height: DataUtils.height * 0.2,
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: DataUtils.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    albaModel.albaPlace,
                    style: w700.copyWith(fontSize: 25),
                  ),
                  SizedBox(height: DataUtils.height * 0.005),
                  SizedBox(
                    height: DataUtils.width * 0.075,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: albaModel.albaDayList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.only(right: DataUtils.width * 0.01),
                            width: DataUtils.width * 0.075,
                            decoration: BoxDecoration(
                                border: Border.all(color: main_color),
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle),
                            child: Text(
                              albaModel.albaDayList[index],
                              style: w700.copyWith(color: main_color),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: DataUtils.height * 0.001),
                  Text(
                      '${DataUtils.timeFormatter(albaModel.startTime)} - ${DataUtils.timeFormatter(albaModel.endTime)}',
                      style: w500),
                  SizedBox(height: DataUtils.height * 0.001),
                  Text('시급 ${albaModel.albaPay}원', style: w500)
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AlbaEditPage(albaModel: albaModel));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DataUtils.width * 0.45,
                  height: DataUtils.height * 0.05,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: background_grey_color),
                    ),
                  ),
                  child: Text('수정',
                      style:
                          w700.copyWith(color: sub_grey_color, fontSize: 15)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: DataUtils.width * 0.45,
                height: DataUtils.height * 0.05,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: background_grey_color),
                  ),
                ),
                child: Text('삭제',
                    style: w700.copyWith(color: main_color, fontSize: 15)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
