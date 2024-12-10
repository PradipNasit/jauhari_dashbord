// To parse this JSON data, do
//
//     final getFaqModel = getFaqModelFromJson(jsonString);

import 'dart:convert';

List<GetFaqModel> getFaqModelFromJson(String str) => List<GetFaqModel>.from(json.decode(str).map((x) => GetFaqModel.fromJson(x)));

String getFaqModelToJson(List<GetFaqModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFaqModel {
  String id;
  String question;
  String answer;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetFaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetFaqModel.fromJson(Map<String, dynamic> json) => GetFaqModel(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
