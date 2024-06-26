import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:mindchain_exchange/user_auth_controller.dart';
import 'package:mindchain_exchange/presentation/screens/sign_in_screen/view/sign_in_screen.dart';
import '../model/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(
      {required String url, bool fromAuth = false}) async {
    String? token = await UserAuthController.getUserToken();
    String? id = await UserAuthController.getUserId();
    try {
      log(url);
      log(UserAuthController.accessToken);
      log(id);
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'token': token,
          'id': id,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        if (!fromAuth) {
          _goToSignInScreen();
        }
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(
          responseCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, var body}) async {
    String? token = await UserAuthController.getUserToken();
    String? id = await UserAuthController.getUserId();
    try {
      log(url);
      log(UserAuthController.accessToken);
      final Response response = await post(Uri.parse(url),
          headers: {
            'accept': 'application/json',
            'token': token,
            'id': id,
          },
          body: body);
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(
          responseCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<void> _goToSignInScreen() async {
    // Navigator.push(
    //   CraftyBay.navigationKey.currentState!.context,
    //   MaterialPageRoute(
    //     builder: (context) => const EmailVerificationScreen(),
    //   ),
    // );

    await UserAuthController.clearUserData();
    getx.Get.to(() => const SignInScreen());
  }
}