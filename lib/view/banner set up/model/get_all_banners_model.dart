// To parse this JSON data, do
//
//     final getAllBanners = getAllBannersFromJson(jsonString);

import 'dart:convert';

List<GetAllBanners> getAllBannersFromJson(String str) => List<GetAllBanners>.from(json.decode(str).map((x) => GetAllBanners.fromJson(x)));

String getAllBannersToJson(List<GetAllBanners> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllBanners {
  String id;
  BannerType bannerType;
  List<Image> image;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetAllBanners({
    required this.id,
    required this.bannerType,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetAllBanners.fromJson(Map<String, dynamic> json) => GetAllBanners(
    id: json["_id"],
    bannerType: bannerTypeValues.map[json["bannerType"]]!,
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
    status: statusValues.map[json["status"]]!,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bannerType": bannerTypeValues.reverse[bannerType],
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
    "status": statusValues.reverse[status],
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

enum BannerType {
  FOOTER,
  MAIN
}

final bannerTypeValues = EnumValues({
  "footer": BannerType.FOOTER,
  "main": BannerType.MAIN
});

class Image {
  String url;
  String id;

  Image({
    required this.url,
    required this.id,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "_id": id,
  };
}

enum Status {
  ACTIVE,
  INACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "inactive": Status.INACTIVE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
