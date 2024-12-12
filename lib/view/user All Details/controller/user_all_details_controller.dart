import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';

class UserAllDetailsController extends GetxController {
  RxBool isGoldWithdrawPopUpShow = false.obs;
  RxBool isOTPPopUpShow = false.obs;

  final userDetailsController = Get.put(UserManagementController());


  final amountController = TextEditingController();
  final noteController = TextEditingController();

  List<Map<String, dynamic>> get userDetailsValue {
    return [
      {
        "title": "User Name",
        "icon": Icons.drive_file_rename_outline,
        "totalValue": userDetailsController.sipData?.user?.fullName ?? "No Name"
      },
      {"title": "User ID", "totalValue": "", "icon": Icons.perm_identity},
      {
        "title": "Mobile",
        "icon": Icons.phone_android,
        "totalValue":
            userDetailsController.sipData?.user?.mobileNumber.toString() ?? ""
      },
      {
        "title": "Adhar card no.",
        "icon": Icons.credit_card_sharp,
        "totalValue":
            userDetailsController.sipData?.user?.aadharCard.toString() ?? ""
      },
      {
        "title": "Total Amount Invested",
        "icon": Icons.currency_rupee,
        "totalValue": userDetailsController.sipData?.user?.totalInvestment
                ?.toStringAsFixed(2) ??
            ""
      },
      {
        "title": "Current Balance",
        "icon": Icons.wallet,
        "totalValue": userDetailsController.sipData?.user?.totalGramsAccumulated
                ?.toStringAsFixed(2) ??
            ""
      },
      {
        "title": "Date of Registration",
        "icon": Icons.date_range,
        "totalValue": DateFormat("dd/MM/yyyy").format(DateTime.parse(
            userDetailsController.sipData?.user?.createdAt.toString() ?? ""))
      },
      {
        "title": "Pan card no.",
        "icon": Icons.credit_card_sharp,
        "totalValue":
            userDetailsController.sipData?.user?.panCard.toString() ?? ""
      },
    ];
  }

  List<Map<String, dynamic>> options = [
    {"title": "Gold Withdrawal History", "totalValue": "UserName"},
    {"title": "User History", "totalValue": "user12458"},
    {"title": "Withdraw Gold", "totalValue": "9536 254 235"},
    {"title": "Add Gold Manually", "totalValue": "9536 254 235"},
  ];

  final box = GetStorage();
  RxBool isWithDrawLoading = false.obs;

  Future<void> goldWithDraw() async {
    isWithDrawLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.withDrawSip,
      requestType: RequestType.POST,
      body: {"sipId": userDetailsController.sipData?.user?.sipId ?? ""},
      headers: {"Authorization": "Bearer $token"},
    );

    isWithDrawLoading.value = false;

    if (response != null && response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      // privacyPolicyController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> addGoldManually() async {
    isWithDrawLoading.value = true;
    String token = box.read("token");

    log(name: "This is sip Id , " , userDetailsController.sipData!.user!.sipId.toString() );

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.addGoldManually,
      requestType: RequestType.POST,
      body: {
        "sipId": userDetailsController.sipData?.user?.sipId ?? "",
        "amount": amountController.text.toString(),
        "adminNote": noteController.text.toString()
      },
      headers: {"Authorization": "Bearer $token"},
    );

    isWithDrawLoading.value = false;

    if (response != null && response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      // privacyPolicyController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }
}
