import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/Business%20set%20up/controller/business_set_up_controller.dart';

import 'widgets/general_widget.dart';

class BusinessSetUpScreen extends StatelessWidget {
  BusinessSetUpScreen({super.key});

  final businessSetUpController = Get.put(BusinessSetUpController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessSetUpController>(builder: (_) {
      return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: ColorHelper.containerBgColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    Spacer(),
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
                TabBar(
                    tabs: [
                  CommonText(text: "General"),
                  CommonText(text: "Payment Option"),
                  CommonText(text: "Orders"),
                  CommonText(text: "Customers"),
                  CommonText(text: "Invoice")
                ]),

                SizedBox(
                  height: Get.height,
                  child: TabBarView(children: [
                    generalWidget(context: context ,controller: businessSetUpController),
                    generalWidget(context: context,controller: businessSetUpController),
                    generalWidget(context: context,controller: businessSetUpController),
                    generalWidget(context: context,controller: businessSetUpController),
                    generalWidget(context: context,controller: businessSetUpController),
                  ]),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
