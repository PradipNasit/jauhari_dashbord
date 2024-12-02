import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jauhari_dashbord/Helper/color_helper.dart';

import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/Sip%20Management%20Screens/controller/sip_management_controller.dart';
import 'package:jauhari_dashbord/view/Sip%20Management%20Screens/widgets/sip_report_widget.dart';

class SipManagementDesktopView extends StatelessWidget {
  SipManagementDesktopView({super.key});

  final sipManagementController = Get.put(SipManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.containerBgColor,
      body: GetBuilder<SipManagementController>(builder: (_) {
        return Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: Get.width * 0.015),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: CommonTextField(
                          hintText: "Search",
                        )),
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
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                        sipManagementController.sipManagementOptions.length,
                        (index) => GestureDetector(
                          onTap: () {
                            sipManagementController.selectedIndex.value = index;
                            sipManagementController.update();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.01),
                              height: 44,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorHelper.brownColor),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: CommonText(
                                text: sipManagementController
                                    .sipManagementOptions[index],
                                color: ColorHelper.brownColor,
                                fontSize: 16,
                              )),
                        ),
                      ),
                    ),
                   sipManagementController.selectedIndex.value == 1
                          ? SipReportWidget(
                              sipManagementController: sipManagementController)
                          : sipManagementController.selectedIndex.value == 0
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.red,
                                )
                              : Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.yellow,
                                ),

                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
