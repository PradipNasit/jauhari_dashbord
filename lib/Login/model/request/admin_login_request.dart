class AdminLogInRequest {

  final String mobileNumber;


  AdminLogInRequest ({
    required this.mobileNumber,

});


  Map<String, dynamic> toJson() {
    return {
      "mobileNumber" : mobileNumber,

    };
  }

}