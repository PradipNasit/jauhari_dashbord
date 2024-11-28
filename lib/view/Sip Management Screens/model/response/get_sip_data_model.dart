// To parse this JSON data, do
//
//     final getSipDataNoidel = getSipDataNoidelFromJson(jsonString);

import 'dart:convert';

List<GetSipDataNoidel> getSipDataNoidelFromJson(String str) => List<GetSipDataNoidel>.from(json.decode(str).map((x) => GetSipDataNoidel.fromJson(x)));

String getSipDataNoidelToJson(List<GetSipDataNoidel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSipDataNoidel {
  String id;
  dynamic userId;
  int monthlyAmount;
  DateTime startDate;
  DateTime nextDueDate;
  String karatage;
  int totalMonths;
  int completedMonths;
  String status;
  double totalGramsAccumulated;
  List<Transaction> transactions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  double totalGoldValue;

  GetSipDataNoidel({
    required this.id,
    required this.userId,
    required this.monthlyAmount,
    required this.startDate,
    required this.nextDueDate,
    required this.karatage,
    required this.totalMonths,
    required this.completedMonths,
    required this.status,
    required this.totalGramsAccumulated,
    required this.transactions,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalGoldValue,
  });

  factory GetSipDataNoidel.fromJson(Map<String, dynamic> json) => GetSipDataNoidel(
    id: json["_id"],
    userId: json["userId"],
    monthlyAmount: json["monthlyAmount"],
    startDate: DateTime.parse(json["startDate"]),
    nextDueDate: DateTime.parse(json["nextDueDate"]),
    karatage: json["karatage"],
    totalMonths: json["totalMonths"],
    completedMonths: json["completedMonths"],
    status: json["status"],
    totalGramsAccumulated: json["totalGramsAccumulated"]?.toDouble(),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    totalGoldValue: json["totalGoldValue"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "monthlyAmount": monthlyAmount,
    "startDate": startDate.toIso8601String(),
    "nextDueDate": nextDueDate.toIso8601String(),
    "karatage": karatage,
    "totalMonths": totalMonths,
    "completedMonths": completedMonths,
    "status": status,
    "totalGramsAccumulated": totalGramsAccumulated,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "totalGoldValue": totalGoldValue,
  };
}

class Transaction {
  DateTime date;
  int amount;
  int goldRate;
  double gramsAccumulated;
  String id;

  Transaction({
    required this.date,
    required this.amount,
    required this.goldRate,
    required this.gramsAccumulated,
    required this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    date: DateTime.parse(json["date"]),
    amount: json["amount"],
    goldRate: json["goldRate"],
    gramsAccumulated: json["gramsAccumulated"]?.toDouble(),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "amount": amount,
    "goldRate": goldRate,
    "gramsAccumulated": gramsAccumulated,
    "_id": id,
  };
}
