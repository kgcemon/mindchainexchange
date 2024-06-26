class MarketInfoModel {
  final String id;
  final String ticker;
  final String name;
  final String icon;
  final double newPrice;
  final double buyPrice;
  final double sellPrice;
  final double minPrice;
  final double maxPrice;
  final double change;
  final double volume;

  MarketInfoModel({
    required this.id,
    required this.ticker,
    required this.name,
    required this.icon,
    required this.newPrice,
    required this.buyPrice,
    required this.sellPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.change,
    required this.volume,
  });

  factory MarketInfoModel.fromJson(Map<String, dynamic> json) {
    return MarketInfoModel(
      id: json['id'],
      ticker: json['ticker'],
      name: json['name'],
      icon: json['icon'],
      newPrice: double.parse(json['new_price']),
      buyPrice: double.parse(json['buy_price']),
      sellPrice: double.parse(json['sell_price']),
      minPrice: double.parse(json['min_price']),
      maxPrice: double.parse(json['max_price']),
      change: json['change'].toDouble(),
      volume: json['volume'].toDouble(),
    );
  }
}
