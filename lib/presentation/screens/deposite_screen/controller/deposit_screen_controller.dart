import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/network_caller/controller/network_caller.dart';
import 'package:mindchain_exchange/presentation/screens/deposite_screen/model/deposit_model.dart';

class DepositScreenController extends GetxController {
  var depositData = DepositModel(status: 0, wallet: '', showqr: 0).obs;

  Future<void> fetchDepositData(String coin) async {
    try {
      final response = await NetworkCaller.getRequest(url: "https://mindchain.info/Api/Crypto/depositaddress/coin/$coin");
      if (response.responseCode == 200) {
        depositData.value = DepositModel.fromJson(response.responseData);
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
