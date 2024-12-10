import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/notification/controller/notification_controller.dart';
import 'widget/manage_notification_widget.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});

   final notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.containerBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.025,
              width: Get.width * 0.025,
            ),
            Row(
              children: [
                SizedBox(width: Get.width * 0.015),
                Flexible(
                  child: CommonTextField(
                    hintText: "Search",
                  ),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorHelper.brownColor,
                  ),
                ),
                CommonText(text: "Your name"),
                SizedBox(width: Get.width * 0.01),
              ],
            ),
            SizedBox(height: Get.height * 0.06),
            manageNotificationWidget(controller: notificationController ,context: context)
          ],
        ),
      ),
    );
  }
}
