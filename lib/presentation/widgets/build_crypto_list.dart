import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mindchain_exchange/presentation/screens/deposite_screen/view/deposit_screen.dart';

import '../screens/wallet_screen/model/wallet_model.dart';

Widget buildCryptoList(List<Crypto> cryptos, var controller) {
  return Obx(() {
    final filteredCryptos = controller.filteredCryptoList;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredCryptos.length,
      itemBuilder: (context, index) {
        final crypto = filteredCryptos[index];
        return _buildCryptoTile(crypto);
      },
    );
  });
}

Widget _buildCryptoTile(Crypto crypto) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => Get.to(() => DepositScreen(
              coinName: crypto.title,
              symbol: crypto.symbol, img: crypto.ico,
            )),
        leading: Image.network(crypto.ico, width: 40, height: 40),
        title: Text(
          crypto.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "Total: ${crypto.total} ${crypto.symbol.toUpperCase()}",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Text(
          "\$${double.parse(crypto.zhehe).toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
