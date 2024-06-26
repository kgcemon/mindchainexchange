import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../model/market_info_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {
  var marketInfoList = <MarketInfoModel>[].obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startFetching();
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    _timer?.cancel();
    super.onClose();
  }

  void startFetching() {
    // Fetch data immediately and then every 3 seconds
    fetchCryptos();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchCryptos();
    });
  }

  Future<void> fetchCryptos() async {
    try {
      final response = await http
          .get(Uri.parse('https://mindchain.info/Api/Index/marketInfo'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['data']['market'];
        List<MarketInfoModel> cryptos = jsonResponse
            .map((crypto) => MarketInfoModel.fromJson(crypto))
            .toList();
        marketInfoList.assignAll(cryptos); // Update the observable list
      } else {
        throw Exception('Failed to load cryptos');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching cryptos: $e');
      }
    }
  }

}
