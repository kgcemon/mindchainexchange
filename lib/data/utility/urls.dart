class Urls {
  static const String _baseUrl = 'https://mindchain.info/Api';

  static const String signUpUrls = '$_baseUrl/Login/emailregister';
  static const String emailCodeUrl = '$_baseUrl/Login/emailcode';
  static const String loginUrls = '$_baseUrl/Login/submit';
  static String emailCodeUrls = '$_baseUrl/Login/emailcode';
  static String forgetPassword = '$_baseUrl/Login/confirmcode';
  static String forgetPasswordCode = '$_baseUrl/Login/forgotcode';

}