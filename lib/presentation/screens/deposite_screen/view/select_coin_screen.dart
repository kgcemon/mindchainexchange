import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/build_crypto_list.dart';
import '../../../widgets/build_search_bar.dart';
import '../../wallet_screen/controller/wallet_screen_controller.dart';

class SelectCoinScreen extends StatefulWidget {
  const SelectCoinScreen({super.key});

  @override
  State<SelectCoinScreen> createState() => _SelectCoinScreenState();
}

class _SelectCoinScreenState extends State<SelectCoinScreen> {
  final WalletScreenController controller = Get.put(WalletScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Select Coin",style: TextStyle(color: Colors.white),),),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              buildSearchBar(controller: controller),
              const SizedBox(height: 15,),
              buildCryptoList(controller.walletData.value!.data,controller),
            ],
          ),
        ),
      ),
    );
  }
}
