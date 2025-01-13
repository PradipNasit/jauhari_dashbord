import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/Login/model/request/admin_login_request.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController {
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  RxBool isSignInLoading = false.obs;
  final box = GetStorage();

  bool isAPICalled = false;

  AdminLogInRequest logInRequest() {
    return AdminLogInRequest(mobileNumber: emailCtr.text.toString());
  }

  @override
  onInit() {
    super.onInit();

    // Add a listener to the controller
    emailCtr.addListener(() {
      final input = emailCtr.text;

      // Check if the input has exactly 10 digits and API has not been called yet
      if (input.length == 10 && !isAPICalled) {
        // Set flag to prevent multiple calls
        isAPICalled = true;
        signIn();
      }
    });
  }

  Future<void> signIn() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request(
        'POST', Uri.parse('http://46.202.163.138:5000/api/admin-login'));
    request.body = json.encode({
      "mobileNumber": emailCtr.text.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Print the response body
    } else {
      print('Request failed: ${response.reasonPhrase}');
    }
  }

  Future<void> verifyOtp() async {
    isSignInLoading.value = true;

    final response = await CommonApiService.request(
        url: "http://46.202.163.138:5000/api/admin/verify/otp",
        requestType: RequestType.POST,
        body: {
          "mobileNumber": 9714961893,
          "otp": passwordCtr.text.toString(),
        },
        headers: {
          'Content-Type': 'application/json'
        });

    isSignInLoading.value = false;
    if (response != null && response.statusCode == 200) {
      box.write("token", jsonDecode(response.body)['token']);
      Get.off(() => BaseLayout(
            navigatorKey: GlobalKey<NavigatorState>(),
          ));

      log(name: "Token", box.read("token"));
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }
}
