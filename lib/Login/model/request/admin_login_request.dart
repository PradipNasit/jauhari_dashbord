class AdminLogInRequest {

  final String email;
  final String password;

  AdminLogInRequest ({
    required this.email,
    required this.password
});


  Map<String, dynamic> toJson() {
    return {
      "email" : email,
      "password" : password
    };
  }

}