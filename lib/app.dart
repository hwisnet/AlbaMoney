import 'package:flutter/material.dart';
import 'package:flutter_project/controller/home_controller.dart';
import 'package:flutter_project/controller/sqflite_controller.dart';
import 'package:flutter_project/page/home_page.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<bool>(
          future: SqfliteController.to.initDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('SQFlite를 지원하지 않습니다'),
              );
            }
            if (snapshot.hasData) {
              Get.put(HomeController());
              return const HomePage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
