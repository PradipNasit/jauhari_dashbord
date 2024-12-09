import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/Login/controller/log_in_controller.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';

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
              height: 350,
              width: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonTextField(hintText: "Enter email"),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonTextField(hintText: "Enter password"),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => ElevatedButton(
                        onPressed: () {
                          logInController.signIn();
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
