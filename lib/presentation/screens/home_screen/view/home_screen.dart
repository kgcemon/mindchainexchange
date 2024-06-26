import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/deposite_screen/view/select_coin_screen.dart';
import 'package:mindchain_exchange/presentation/screens/home_screen/controller/home_screen_controller.dart';
import 'package:mindchain_exchange/presentation/screens/wallet_screen/controller/wallet_screen_controller.dart';
import '../../../widgets/costom_cryptoList.dart';
import '../../main_nav_screen/controller/nav_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.put(HomeScreenController());
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainWallet(),
              const SizedBox(height: 20),
              const ActionButtons(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[850]),
                  child: const TabBar(
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: 'Favorite'),
                      Tab(text: 'Gainer'),
                      Tab(text: 'Loser'),
                      Tab(text: 'New'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.marketInfoList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return TabBarView(
                      children: [
                        CryptoList(
                          cryptos: controller.marketInfoList,
                          filter: (crypto) => true,
                          color: Colors.amber,
                        ),
                        CryptoList(
                          cryptos: controller.marketInfoList,
                          filter: (crypto) => crypto.change > 0,
                          color: Colors.green,
                        ),
                        CryptoList(
                          cryptos: controller.marketInfoList,
                          filter: (crypto) => crypto.change < 0,
                          color: Colors.red,
                        ),
                        CryptoList(
                          cryptos: controller.marketInfoList.reversed.toList(),
                          filter: (crypto) => true,
                          color: Colors.blue,
                        ),
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
}

class MainWallet extends StatelessWidget {
  const MainWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Main Wallet',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Text(
              "\$${Get.find<WalletScreenController>().walletData.value?.fiat.worth.obs.toStringAsFixed(2) ?? "0.0"}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const SelectCoinScreen());
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.amber),
            child: const Text('Deposits'),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () => Get.find<NavScreenController>().currentIndex = 1,
              child: const ActionButton(title: 'Spot Trading')),
          const SizedBox(width: 15),
          InkWell(
              onTap: () => Get.find<NavScreenController>().changeScreen(1),
              child: const ActionButton(title: 'Wallet')),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;

  const ActionButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Limit Market, Stop Limit Orders",
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
