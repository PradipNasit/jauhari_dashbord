class CreateSipRequestModel {


  final  int monthlyAmount;


  CreateSipRequestModel ({
    required this.monthlyAmount
});

  Map<String , dynamic>
 toJson() {

    return {
      "monthlyAmount" : monthlyAmount
    };
  }


}