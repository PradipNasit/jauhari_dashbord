import 'package:get/get.dart';

class UserAllDetailsController extends GetxController {

  RxBool isGoldWithdrawPopUpShow = false.obs;
  RxBool isOTPPopUpShow = false.obs;

  List<Map<String, dynamic>> userDetailsValue = [
    {"title": "User Name", "totalValue": "UserName"},
    {"title": "User ID", "totalValue": "user12458"},
    {"title": "Mobile", "totalValue": "9536 254 235"},
    {"title": "Adhar card no.", "totalValue": "9536 254 235"},
    {"title": "Total Amount Invested Across All GSPs Till Last Payment Date", "totalValue": "56,000"},
    {"title": "Total Gold Bought Across all GSPs Till Last Payment Date", "totalValue": "8 grams"},
    {"title": "Date of Registration", "totalValue": "1/1/2024"},
    {"title": "Pan card no.", "totalValue": "Cann123456"},
  ];


  List<Map<String, dynamic>> options = [
    {"title": "Gold Withdrawal History", "totalValue": "UserName"},
    {"title": "User History", "totalValue": "user12458"},
    {"title": "Withdraw Gold", "totalValue": "9536 254 235"},

  ];
}
