class Urls {
  static const String _baseUrl = 'https://mindchain.info/Api';

  static const String signUpUrls = '$_baseUrl/Login/emailregister';
  static const String emailCodeUrl = '$_baseUrl/Login/emailcode';

  static String emailCodeUrls() =>
      '$_baseUrl/Login/emailcode';

}