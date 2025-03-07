import 'package:flutter_project/controller/sqflite_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SqfliteController());
  }
}
