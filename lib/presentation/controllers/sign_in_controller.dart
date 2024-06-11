import 'dart:convert';

import 'package:get/get.dart';
import 'package:mindchain_exchange/data/model/network_response.dart';
import 'package:mindchain_exchange/data/network_caller.dart';
import 'package:mindchain_exchange/data/utility/urls.dart';
import 'package:mindchain_exchange/presentation/controllers/user_auth_controller.dart';

class SingInController extends GetxController {
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> getUserLogin(String username, String password) async {
    try {
      NetworkResponse response = await NetworkCaller.postRequest(
          url: Urls.loginUrls,
          body: jsonEncode({"username": username, "password": password}));
      if (response.responseCode == 200) {
        print(username);
        if (response.responseData['status'] == 1) {
          UserAuthController.saveUserToken(
              response.responseData['data']['TOKEN']);
          return true;
        } else if (response.responseData['status'] == 0) {
          _errorMessage = response.responseData['data'];
          return false;
        } else {
          throw Exception("Unknown error occurred");
        }
      } else {
        throw Exception("Failed to connect to server");
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
