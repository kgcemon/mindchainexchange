import 'dart:async';
import 'package:get/get.dart';
import 'package:mindchain_exchange/data/network_caller.dart';
import 'package:mindchain_exchange/data/utility/urls.dart';

class ForgotMyPasswordController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  final RxString _sendButtonText = ''.obs;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  RxString get sendButtonText => _sendButtonText;

  Future<bool> changePasswordUser(
      String email, String otp, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "verify_code": otp,
      "password": password,
    };
    try {
      var response =
          await NetworkCaller.postRequest(url: Urls.forgetPassword,
              body: body);
      if (response.responseCode == 200) {
        _errorMessage = response.responseData['data'];
        _inProgress = false;
        return true;
      } else {
        _errorMessage = response.errorMessage;
        _inProgress = false;
        return false;
      }
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
  }

  Future<String> sendEmail(String email) async {
    _getSendCodeAgain();
    var response = await NetworkCaller.postRequest(
        url: Urls.forgetPasswordCode, body: {"email": email});
    if (response.responseData['status'] == 1) {
      update();
      return response.responseData['data'];
    } else {
      _errorMessage = response.responseData['data'];
      update();
      return response.responseData['data'];
    }
  }

  void _getSendCodeAgain() {
    int num = 10;
    int nextTime = num;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      num -= 1;
      _sendButtonText.value = 'Wait $num';
      if (num == 0) {
        _sendButtonText.value = '';
        print(num);
        timer.cancel();
      }
    });
    num += num + nextTime;
  }
}
