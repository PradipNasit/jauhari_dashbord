import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/Business%20set%20up/model/request/create_business_request_model.dart';

class BusinessSetUpController extends GetxController {
  RxBool switchValue = false.obs;
  RxBool isSignInLoading = false.obs;

  final companyName = TextEditingController();
  final companyAddress = TextEditingController();
  final companyEmail = TextEditingController();
  final companyPhone = TextEditingController();
  final timeZone = TextEditingController();
  final language = TextEditingController();
  final copyRightText = TextEditingController();
  final country = TextEditingController();

  CreateBusinessRequestModel createBusinessRequestModel() {
    return CreateBusinessRequestModel(
        companyName: companyName.text,
        country: country.text,
        companyAddress: companyAddress.text,
        companyEmail: companyEmail.text,
        companyPhone: companyPhone.text,
        copyRightText: copyRightText.text,
        language: language.text,
        timeZone: timeZone.text);
  }

  void clearRequestModel() {
    companyName.clear();
    country.clear();
    companyAddress.clear();
    companyEmail.clear();
    companyPhone.clear();
    copyRightText.clear();
    language.clear();
    timeZone.clear();
  }

  final box = GetStorage();

  Future<void> createBusiness() async {
    isSignInLoading.value = true;
    String token = box.read("token");

    final requestData = createBusinessRequestModel();

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.createBusiness,
      requestType: RequestType.POST,
      body: requestData.toJson(),
      headers: {"Authorization": "Bearer $token"},
    );

    isSignInLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      clearRequestModel();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }
}
