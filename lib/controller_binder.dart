import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/forgot_my_password/controller/forgot_my_password_controller.dart';
import 'package:mindchain_exchange/presentation/screens/home_screen/controller/home_screen_controller.dart';
import 'package:mindchain_exchange/presentation/screens/sign_in_screen/controller/sign_in_controller.dart';
import 'package:mindchain_exchange/presentation/screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:mindchain_exchange/presentation/screens/wallet_screen/controller/wallet_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(SingInController());
    Get.put(ForgotMyPasswordController());
    Get.put(HomeScreenController());
    Get.put(WalletScreenController());
  }}