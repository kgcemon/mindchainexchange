import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:mindchain_exchange/network_caller/controller/network_caller.dart';
import 'package:mindchain_exchange/network_caller/model/network_response.dart';
import 'package:mindchain_exchange/network_caller/utility/urls.dart';
import 'package:mindchain_exchange/presentation/screens/sign_in_screen/view/sign_in_screen.dart';
import 'package:mindchain_exchange/user_auth_controller.dart';
import '../model/wallet_model.dart';

class WalletScreenController extends GetxController {
  var isLoading = true.obs;
  var walletData = Rxn<WalletData>();
  var filteredCryptoList = <Crypto>[].obs;

  Future<void> fetchWalletData() async {
    try {
      if(walletData.value.toString().isEmpty){
        isLoading.value = true;
      }
      NetworkResponse response = await NetworkCaller.getRequest(
          url: Urls.walletUrls);
      if (response.responseCode == 200) {
        if(response.responseData['status'] == -99){
          UserAuthController.clearUserData().then(
                (value) => Get.offAll(() => const SignInScreen()),
          );
        }
        walletData.value = WalletData.fromJson(response.responseData);
        filterCrypto('');
      } else {
        throw Exception('Failed to load wallet data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching wallet data: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void filterCrypto(String query) {
    if (walletData.value != null) {
      if (query.isNotEmpty) {
        var filtered = walletData.value!.data
            .where((crypto) =>
                crypto.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        filteredCryptoList.assignAll(filtered);
      } else {
        filteredCryptoList.assignAll(walletData.value!.data);
      }
    }
  }
}
