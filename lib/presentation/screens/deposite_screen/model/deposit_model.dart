import 'dart:convert';

DepositModel depositModelFromJson(String str) => DepositModel.fromJson(json.decode(str));

String depositModelToJson(DepositModel data) => json.encode(data.toJson());

class DepositModel {
  int status;
  String wallet;
  int showqr;

  DepositModel({
    required this.status,
    required this.wallet,
    required this.showqr,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
    status: json["status"],
    wallet: json["wallet"],
    showqr: json["showqr"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "wallet": wallet,
    "showqr": showqr,
  };
}
