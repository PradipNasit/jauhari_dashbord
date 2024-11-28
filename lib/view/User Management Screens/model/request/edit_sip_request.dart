class EditSipRequest  {



  final String id;
  final String status;

  EditSipRequest({
    required this.id,
    required this.status
});


  Map<String , dynamic> toJson() {
    return {
      "id": id,
      "status": status,
    };
  }
}