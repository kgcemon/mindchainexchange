import 'package:flutter/material.dart';

import '../../data/model/market_info_model.dart';
import 'crypto_tile_widget.dart';

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