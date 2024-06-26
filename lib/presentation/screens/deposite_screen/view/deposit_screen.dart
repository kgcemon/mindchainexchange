import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/deposite_screen/controller/deposit_screen_controller.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class DepositScreen extends StatelessWidget {
  final String coinName;
  final String symbol;
  final String img;

  const DepositScreen(
      {super.key,
      required this.coinName,
      required this.symbol,
      required this.img});

  @override
  Widget build(BuildContext context) {
    final DepositScreenController controller =
        Get.put(DepositScreenController());
    controller.fetchDepositData(symbol);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Deposit Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.topLeft,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.7)),
              child: Column(
                children: [
                  Image.network(
                    img,
                    height: 80,
                  ),
                  const Text(
                    "Selected Coin",
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Text(
                      coinName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Obx(
                      () => controller.depositData.value.wallet.isEmpty
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    controller.depositData.value.wallet,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: controller.depositData.value.wallet));
                                      Get.snackbar(
                                        "Copied",
                                        "Wallet address copied to clipboard",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.black,
                                        colorText: Colors.white,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                        ,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150,
                    child: Obx(() => controller.depositData.value.wallet.isEmpty
                        ? const CupertinoActivityIndicator(
                      color: Colors.white,
                    ) : PrettyQrView.data(
                        data: controller.depositData.value.wallet,
                        decoration: const PrettyQrDecoration(),)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
