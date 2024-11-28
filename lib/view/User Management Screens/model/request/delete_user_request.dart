class DeleteUserRequest {

  final String  id;



  DeleteUserRequest ({
    required this.id
});


  Map<String , dynamic> toJson () {
    return {
      "id" : id
    };
  }

}