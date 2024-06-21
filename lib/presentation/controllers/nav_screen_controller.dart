import 'package:get/get.dart';

class NavScreenController extends GetxController {
  var currentIndex = 0;
  void changeScreen(int index) {
    currentIndex = index;
    update();
  }
}