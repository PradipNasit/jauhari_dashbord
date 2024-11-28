class CreateBusinessRequestModel {
  final String companyName;
  final String companyAddress;
  final String companyEmail;
  final String companyPhone;
  final String timeZone;
  final String language;
  final String copyRightText;
  final String country;

  CreateBusinessRequestModel({
    required this.companyName,
    required this.country,
    required this.companyAddress,
    required this.companyEmail,
    required this.companyPhone,
    required this.copyRightText,
    required this.language,
    required this.timeZone,
  });

  Map<String, dynamic> toJson() {
    return {
      "companyName": companyName,
      "companyAddress": companyAddress,
      "companyEmail": companyEmail,
      "companyPhone": companyPhone,
      "timeZone": timeZone,
      "language": language,
      "copyRightText": copyRightText,
      "country": country
    };
  }
}
