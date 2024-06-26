import 'package:shared_preferences/shared_preferences.dart';

class UserAuthController {
  static String accessToken = '';
  static String accessId = '';

  static const String _tokenKey = 'token';
  static const String _id = 'id';

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    accessToken = token;
  }

  static Future<void> saveUserId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_id, id);
    accessId = id;
  }

  static Future<String> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    accessToken = token ?? '';
    return accessToken;
  }

  static Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? id = sharedPreferences.getString(_id);
    accessId = id ?? '';
    return accessId;
  }

  static Future<bool> checkLoggedInState() async {
    String token = await getUserToken();
    return token.isNotEmpty;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = '';
  }
}