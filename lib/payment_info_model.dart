// To parse this JSON data, do
//
//     final paymentInfoModel = paymentInfoModelFromJson(jsonString);

import 'dart:convert';

List<PaymentInfoModel> paymentInfoModelFromJson(String str) => List<PaymentInfoModel>.from(json.decode(str).map((x) => PaymentInfoModel.fromJson(x)));

String paymentInfoModelToJson(List<PaymentInfoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentInfoModel {
  final String? id;
  final UserId? userId;
  final String? screenShot;
  final String? upiId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PaymentInfoModel({
    this.id,
    this.userId,
    this.screenShot,
    this.upiId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) => PaymentInfoModel(
    id: json["_id"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    screenShot: json["screenShot"],
    upiId: json["upiId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "screenShot": screenShot,
    "upiId": upiId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserId {
  final String? id;
  final String? fullName;
  final int? mobileNumber;

  UserId({
    this.id,
    this.fullName,
    this.mobileNumber,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["fullName"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "mobileNumber": mobileNumber,
  };
}
