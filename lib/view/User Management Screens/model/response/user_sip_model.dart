// To parse this JSON data, do
//
//     final userSIpData = userSIpDataFromJson(jsonString);

import 'dart:convert';

UserSIpData userSIpDataFromJson(String str) => UserSIpData.fromJson(json.decode(str));

String userSIpDataToJson(UserSIpData data) => json.encode(data.toJson());

class UserSIpData {
  User? user;

  UserSIpData({
    this.user,
  });

  factory UserSIpData.fromJson(Map<String, dynamic> json) => UserSIpData(
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };
}

class User {
  String? id;
  String? fullName;
  int? mobileNumber;
  String? email;
  String? role;
  int? aadharCard;
  String? panCard;
  String? nomineeName;
  int? nomineeNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalInvestment;
  double? totalGramsAccumulated;
  String? sipId;

  User({
    this.id,
    this.fullName,
    this.mobileNumber,
    this.email,
    this.role,
    this.aadharCard,
    this.panCard,
    this.nomineeName,
    this.nomineeNumber,
    this.createdAt,
    this.updatedAt,
    this.totalInvestment,
    this.totalGramsAccumulated,
    this.sipId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] as String?,
    fullName: json["fullName"] as String?,
    mobileNumber: json["mobileNumber"] is int ? json["mobileNumber"] as int? : null,
    email: json["email"] as String?,
    role: json["role"] as String?,
    aadharCard: json["aadharCard"] is int ? json["aadharCard"] as int? : null,
    panCard: json["panCard"] as String?,
    nomineeName: json["nomineeName"] as String?,
    nomineeNumber: json["nomineeNumber"] is int ? json["nomineeNumber"] as int? : null,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    totalInvestment: json["totalInvestment"] is int ? json["totalInvestment"] as int? : null,
    totalGramsAccumulated: json["totalGramsAccumulated"] != null
        ? (json["totalGramsAccumulated"] as num?)?.toDouble()
        : null,
    sipId: json["sipId"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "mobileNumber": mobileNumber,
    "email": email,
    "role": role,
    "aadharCard": aadharCard,
    "panCard": panCard,
    "nomineeName": nomineeName,
    "nomineeNumber": nomineeNumber,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "totalInvestment": totalInvestment,
    "totalGramsAccumulated": totalGramsAccumulated,
    "sipId": sipId,
  };
}
