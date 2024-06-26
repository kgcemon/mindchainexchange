class WalletData {
  final int status;
  final String message;
  final List<Crypto> data;
  final Fiat fiat;

  WalletData({
    required this.status,
    required this.message,
    required this.data,
    required this.fiat,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Crypto> dataList = list.map((i) => Crypto.fromJson(i)).toList();

    return WalletData(
      status: json['status'],
      message: json['message'],
      data: dataList,
      fiat: Fiat.fromJson(json['fiat']),
    );
  }
}

class Fiat {
  final double worth;
  final double intrading;
  final double available;

  Fiat({
    required this.worth,
    required this.intrading,
    required this.available,
  });

  factory Fiat.fromJson(Map<String, dynamic> json) {
    return Fiat(
      worth: json['worth']?.toDouble() ?? 0.0,
      intrading: json['intrading']?.toDouble() ?? 0.0,
      available: json['available']?.toDouble() ?? 0.0,
    );
  }
}

class Crypto {
  final String id;
  final String type;
  final int sort;
  final String name;
  final String symbol;
  final String ico;
  final String title;
  final double total;
  final String xnb;
  final String xnbd;
  final String xnbz;
  final double jia;
  final String zhehe;
  final int deposits;
  final int withdrawals;
  final String minWithdrawal;
  final String withdrawFees;

  Crypto({
    required this.id,
    required this.type,
    required this.sort,
    required this.name,
    required this.symbol,
    required this.ico,
    required this.title,
    required this.total,
    required this.xnb,
    required this.xnbd,
    required this.xnbz,
    required this.jia,
    required this.zhehe,
    required this.deposits,
    required this.withdrawals,
    required this.minWithdrawal,
    required this.withdrawFees,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      type: json['type'],
      sort: json['sort'],
      name: json['name'],
      symbol: json['symbol'],
      ico: json['ico'],
      title: json['title'],
      total: json['total']?.toDouble() ?? 0.0,
      xnb: json['xnb'],
      xnbd: json['xnbd'],
      xnbz: json['xnbz'],
      jia: json['jia']?.toDouble() ?? 0.0,
      zhehe: json['zhehe'],
      deposits: json['deposits'],
      withdrawals: json['withdrawals'],
      minWithdrawal: json['min_withdrawal'],
      withdrawFees: json['withdraw_fees'],
    );
  }
}
