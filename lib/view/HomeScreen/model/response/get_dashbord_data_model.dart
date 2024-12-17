// To parse this JSON data, do
//
//     final getDashBordDataModel = getDashBordDataModelFromJson(jsonString);

import 'dart:convert';

GetDashBordDataModel getDashBordDataModelFromJson(String str) => GetDashBordDataModel.fromJson(json.decode(str));

String getDashBordDataModelToJson(GetDashBordDataModel data) => json.encode(data.toJson());

class GetDashBordDataModel {
  int totalUsers;
  int activeSiPs;
  int completedSiPs;
  TotalPayments totalPayments;
  double totalGoldAccumulated;

  GetDashBordDataModel({
    required this.totalUsers,
    required this.activeSiPs,
    required this.completedSiPs,
    required this.totalPayments,
    required this.totalGoldAccumulated,
  });

  factory GetDashBordDataModel.fromJson(Map<String, dynamic> json) => GetDashBordDataModel(
    totalUsers: json["totalUsers"],
    activeSiPs: json["activeSIPs"],
    completedSiPs: json["completedSIPs"],
    totalPayments: TotalPayments.fromJson(json["totalPayments"]),
    totalGoldAccumulated: json["totalGoldAccumulated"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalUsers": totalUsers,
    "activeSIPs": activeSiPs,
    "completedSIPs": completedSiPs,
    "totalPayments": totalPayments.toJson(),
    "totalGoldAccumulated": totalGoldAccumulated,
  };
}

class TotalPayments {
  dynamic  amount;
  dynamic count;

  TotalPayments({
    required this.amount,
    required this.count,
  });

  factory TotalPayments.fromJson(Map<String, dynamic> json) => TotalPayments(
    amount: json["amount"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "count": count,
  };
}
