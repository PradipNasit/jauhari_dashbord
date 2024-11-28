// To parse this JSON data, do
//
//     final getUserDataNoidel = getUserDataNoidelFromJson(jsonString);

import 'dart:convert';

List<GetUserDataModel> getUserDataNoidelFromJson(String str) => List<GetUserDataModel>.from(json.decode(str).map((x) => GetUserDataModel.fromJson(x)));

String getUserDataNoidelToJson(List<GetUserDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUserDataModel {
  String id;
  String fullName;
  int mobileNumber;
  String email;
  int aadharCard;
  String panCard;
  String nomineeName;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String sipStatus;
  int? nomineeNumber;

  GetUserDataModel({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.aadharCard,
    required this.panCard,
    required this.nomineeName,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sipStatus,
    this.nomineeNumber,
  });

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) => GetUserDataModel(
    id: json["_id"],
    fullName: json["fullName"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    aadharCard: json["aadharCard"],
    panCard: json["panCard"],
    nomineeName: json["nomineeName"],
    role: json["role"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    sipStatus: json["sipStatus"],
    nomineeNumber: json["nomineeNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "mobileNumber": mobileNumber,
    "email": email,
    "aadharCard": aadharCard,
    "panCard": panCard,
    "nomineeName": nomineeName,
    "role": role,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "sipStatus": sipStatus,
    "nomineeNumber": nomineeNumber,
  };
}
