import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/controllers/home_screen_controller.dart';
import '../../data/model/market_info_model.dart';
import '../widgets/crypto_tile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final HomeScreenController controller = Get.put(HomeScreenController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Crypto Market'),
          actions: const [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainWallet(),
              const SizedBox(height: 20),
              const _ActionButtons(),
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
                          cryptos: controller.marketInfoList,
                          filter: (crypto) => true, // Adjust the filter for new coins
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
          const Text(
            '\$763.90',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text('Deposit'),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(title: 'Spot Trading'),
          SizedBox(width: 15),
          ActionButton(title: 'Wallet'),
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

class CryptoList extends StatelessWidget {
  final List<MarketInfoModel> cryptos;
  final bool Function(MarketInfoModel) filter;
  final Color color;

  const CryptoList({
    required this.cryptos,
    required this.filter,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filteredCryptos = cryptos.where(filter).toList();
    return ListView(
      children: filteredCryptos.map((crypto) {
        return CryptoTile(
          name: crypto.name,
          price: crypto.newPrice.toStringAsFixed(2),
          change: '${crypto.change.toStringAsFixed(2)}%',
          color: color,
          volume: crypto.volume.toStringAsFixed(2),
          img: crypto.icon,
        );
      }).toList(),
    );
  }
}
