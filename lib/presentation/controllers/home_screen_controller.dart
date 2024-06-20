import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../../data/model/market_info_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {
  // Observable list to store the fetched market information
  var marketInfoList = <MarketInfoModel>[].obs;

  // Timer variable to periodically fetch the data
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Start the periodic fetching when the controller is initialized
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
      print('Error fetching cryptos: $e');
    }
  }
}
