class EditUserRequest {

  final String id;
  final String fullName;
  final String mobileNumber;
  final String email;
    final String nomineeName;
    final  String nomineeNunmber;
    final String aadharCard;
    final String panCard;


    EditUserRequest ({
    required this.fullName,
      required this.mobileNumber,
      required this.nomineeName,
      required this.email,
      required this.aadharCard,
      required this.id,
      required this.panCard,
      required this.nomineeNunmber
});


  Map<String , dynamic> tojson () {
      return {
"id" : id,
        "fullName" : fullName,
        "mobileNumber" : mobileNumber,
        "email" : email,
        "nomineeName" : nomineeName,
        "nomineeNumber" : nomineeNunmber,
        "aadharCard" : aadharCard,
        "panCard" : panCard,
      };
  }

}