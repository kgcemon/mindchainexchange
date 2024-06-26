import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/deposite_screen/view/select_coin_screen.dart';
import '../../../widgets/build_crypto_list.dart';
import '../../../widgets/build_search_bar.dart';
import '../controller/wallet_screen_controller.dart';
import '../model/wallet_model.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    Get.find<WalletScreenController>().fetchWalletData();
    super.initState();
  }

  final WalletScreenController controller = Get.put(WalletScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<WalletScreenController>().fetchWalletData();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.walletData.value == null) {
                    return const Center(
                        child: Text("Failed to load wallet data"));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBalanceSection(controller.walletData.value!.fiat),
                        const SizedBox(height: 10),
                        buildSearchBar(controller: controller),
                        const SizedBox(height: 10),
                        buildCryptoList(controller.walletData.value!.data,controller),
                      ],
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceSection(Fiat fiatData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Wallet Balance",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${fiatData.worth.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () => Get.to(()=>const SelectCoinScreen()),
                      child: const Text(
                        "Deposit",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: const Text("Withdraw")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
