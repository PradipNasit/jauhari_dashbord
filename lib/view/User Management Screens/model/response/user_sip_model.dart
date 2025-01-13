// To parse this JSON data, do
//
//     final userSIpData = userSIpDataFromJson(jsonString);

import 'dart:convert';

UserSIpData userSIpDataFromJson(String str) => UserSIpData.fromJson(json.decode(str));

String userSIpDataToJson(UserSIpData data) => json.encode(data.toJson());

class UserSIpData {
  UserWithActiveSip userWithActiveSip;
  List<SipDetail> sipDetails;

  UserSIpData({
    required this.userWithActiveSip,
    required this.sipDetails,
  });

  factory UserSIpData.fromJson(Map<String, dynamic> json) => UserSIpData(
    userWithActiveSip: UserWithActiveSip.fromJson(json["userWithActiveSIP"]),
    sipDetails: List<SipDetail>.from(json["sipDetails"]?.map((x) => SipDetail.fromJson(x)) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "userWithActiveSIP": userWithActiveSip.toJson(),
    "sipDetails": sipDetails.map((x) => x.toJson()).toList(),
  };
}

class SipDetail {
  String? id;
  String? userId;
  double? monthlyAmount;
  DateTime? startDate;
  DateTime? nextDueDate;
  String? karatage;
  int? totalMonths;
  int? completedMonths;
  String? status;
  double? totalGramsAccumulated;
  List<Transaction>? transactions;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  double? totalInvestment;

  SipDetail({
    this.id,
    this.userId,
    this.monthlyAmount,
    this.startDate,
    this.nextDueDate,
    this.karatage,
    this.totalMonths,
    this.completedMonths,
    this.status,
    this.totalGramsAccumulated,
    this.transactions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalInvestment,
  });

  factory SipDetail.fromJson(Map<String, dynamic> json) => SipDetail(
    id: json["_id"],
    userId: json["userId"],
    monthlyAmount: json["monthlyAmount"]?.toDouble(),
    startDate: json["startDate"] != null ? DateTime.parse(json["startDate"]) : null,
    nextDueDate: json["nextDueDate"] != null ? DateTime.parse(json["nextDueDate"]) : null,
    karatage: json["karatage"],
    totalMonths: json["totalMonths"],
    completedMonths: json["completedMonths"],
    status: json["status"],
    totalGramsAccumulated: json["totalGramsAccumulated"]?.toDouble(),
    transactions: json["transactions"] != null
        ? List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x)))
        : null,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    v: json["__v"],
    totalInvestment: json["totalInvestment"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "monthlyAmount": monthlyAmount,
    "startDate": startDate?.toIso8601String(),
    "nextDueDate": nextDueDate?.toIso8601String(),
    "karatage": karatage,
    "totalMonths": totalMonths,
    "completedMonths": completedMonths,
    "status": status,
    "totalGramsAccumulated": totalGramsAccumulated,
    "transactions": transactions?.map((x) => x.toJson()).toList(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "totalInvestment": totalInvestment,
  };
}

class Transaction {
  DateTime? date;
  double? amount;
  int? goldRate;
  double? gramsAccumulated;
  double? gstAmount;
  String? transactionType;
  String? adminNote;
  String? id;

  Transaction({
    this.date,
    this.amount,
    this.goldRate,
    this.gramsAccumulated,
    this.gstAmount,
    this.transactionType,
    this.adminNote,
    this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    amount: json["amount"]?.toDouble(),
    goldRate: json["goldRate"],
    gramsAccumulated: json["gramsAccumulated"]?.toDouble(),
    gstAmount: json["gstAmount"]?.toDouble(),
    transactionType: json["transactionType"],
    adminNote: json["adminNote"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "amount": amount,
    "goldRate": goldRate,
    "gramsAccumulated": gramsAccumulated,
    "gstAmount": gstAmount,
    "transactionType": transactionType,
    "adminNote": adminNote,
    "_id": id,
  };
}

class UserWithActiveSip {
  bool? mobileNumberVerified;
  String? id;
  String? fullName;
  int? mobileNumber;
  String? email;
  int? aadharCard;
  String? panCard;
  String? nomineeName;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  dynamic activeSIPTotalInvestment;
  double? totalGramsAccumulated;

  UserWithActiveSip({
    this.mobileNumberVerified,
    this.id,
    this.fullName,
    this.mobileNumber,
    this.email,
    this.aadharCard,
    this.panCard,
    this.nomineeName,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.activeSIPTotalInvestment,
    this.totalGramsAccumulated,
  });

  factory UserWithActiveSip.fromJson(Map<String, dynamic> json) => UserWithActiveSip(
    mobileNumberVerified: json["mobileNumberVerified"],
    id: json["_id"],
    fullName: json["fullName"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    aadharCard: json["aadharCard"],
    panCard: json["panCard"],
    nomineeName: json["nomineeName"],
    role: json["role"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    activeSIPTotalInvestment: json['activeSIPTotalInvestment'],
    v: json["__v"],
    totalGramsAccumulated: json["totalGramsAccumulated"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "mobileNumberVerified": mobileNumberVerified,
    "_id": id,
    "fullName": fullName,
    "mobileNumber": mobileNumber,
    "email": email,
    "aadharCard": aadharCard,
    "panCard": panCard,
    "nomineeName": nomineeName,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "totalGramsAccumulated": totalGramsAccumulated,
    'activeSIPTotalInvestment': activeSIPTotalInvestment,
  };
}
