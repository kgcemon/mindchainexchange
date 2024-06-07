import 'dart:convert';

import 'package:get/get.dart';
import 'package:mindchain_exchange/data/network_caller.dart';
import 'package:mindchain_exchange/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> registerUser(
      String username, String email, String otp, String password) async {
    print(username);
    Map<String, dynamic> body = {
      "username": username,
      "email": email,
      "verify": otp,
      "password": password,
    };
    try {
      var response =
          await NetworkCaller.postRequest(url: Urls.signUpUrls, body: body);
      if (response.responseCode == 200) {
        print(response.responseData);
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

  Future<bool> sendEmail(String email) async {
    print(email);
    var response = await NetworkCaller.postRequest(
        url: Urls.emailCodeUrl, body: jsonEncode({"email": email}));
    if (response.responseData['status'] == 1) {
      update();
      return true;
    } else {
      _errorMessage = response.responseData['data'];
      update();
      return false;
    }
  }
}
