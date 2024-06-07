import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/controllers/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }}