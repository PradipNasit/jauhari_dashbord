
class UserDetails {
  final String id;
   String fullName;
  final String mobileNumber;
  final String email;
  final String aadharCard;
  final String panCard;
  final String nomineeName;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
   String sipStatus;
  final String? nomineeNumber;
  final bool isReadOnly;

  UserDetails({
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
    required this.sipStatus,
    this.isReadOnly = false,
    this.nomineeNumber,
  });
}