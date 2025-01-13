class DeleteUserRequest {

  final String  id;
  final String  otp;



  DeleteUserRequest ({
    required this.id,
    required this.otp
});


  Map<String , dynamic> toJson () {
    return {
      "userId " : id,
      "otp" : otp
    };
  }

}