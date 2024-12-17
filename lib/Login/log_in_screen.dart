import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/Login/controller/log_in_controller.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/view/HomeScreen/page/home_page.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.brownColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 450,
              width: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonTextField(hintText: "Enter mobile number", controller: logInController.emailCtr,maxCount: 10,keyboardType: TextInputType.number,),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonTextField(hintText: "Enter OTP",controller: logInController.passwordCtr,),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => ElevatedButton(
                        onPressed: () {
                          String token =
                              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NTZkODVmZWVmOTFlYmViYzA5M2IyYyIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTczMzgwMjY3Nn0.S0CvlPfr7qiKCE_-2S5QCVFCBJTzvLQnQhs5JV1sVbQ";
                          logInController.box.write("token", token);

                          logInController.verifyOtp();
                        },
                        child: logInController.isSignInLoading.value
                            ? const CupertinoActivityIndicator()
                            : const Text("Sing in")),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
