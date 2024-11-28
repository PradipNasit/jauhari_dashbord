import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/Login/model/request/admin_login_request.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/HomeScreen/page/home_page.dart';

class LogInController extends GetxController {

final emailCtr = TextEditingController();
final passwordCtr = TextEditingController();



RxBool isSignInLoading = false.obs;
final box = GetStorage();



AdminLogInRequest  logInRequest () {
  return AdminLogInRequest(email: "jauharitech@gmail.com", password: "jauhari");
}




Future<void> signIn() async {
  isSignInLoading.value = true;

  final requestData = logInRequest();

  final response = await CommonApiService.request(
      url: Api.baseUrl + Api.logIn,
      requestType: RequestType.POST,
      body: requestData.toJson());

  isSignInLoading.value = false;

  if (response != null && response.statusCode == 200) {
    box.write("token", jsonDecode(response.body)['token']);

    Get.to(()=> HomePage());

    log(name: "Token", box.read("token"));

  } else {
    print('Failed to send data: ${response?.statusCode}');
  }
}


}