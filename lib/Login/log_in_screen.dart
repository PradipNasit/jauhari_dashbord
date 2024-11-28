import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Login/controller/log_in_controller.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';

class LogInScreen extends StatelessWidget {
   LogInScreen({super.key});

  final logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonTextField(hintText: "Enter email"),
          CommonTextField(hintText: "Enter password"),

          Obx(
         () =>  ElevatedButton(onPressed: () {
              logInController.signIn();

            }, child: logInController.isSignInLoading.value ? CupertinoActivityIndicator() : Text( "Sing in")),
          )
        ],
      ),
    );
  }
}
