import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/user_sip_model.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/controller/user_all_details_controller.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/widgets/transaction_history.dart';

Widget userAllDetailsDesktopView(
    {UserAllDetailsController? controller,
    required BuildContext context,
    UserSIpData? data,
    UserManagementController? userManagementController}) {
  return GetBuilder<UserAllDetailsController>(builder: (_) {
    return Scaffold(
      backgroundColor: ColorHelper.containerBgColor,
      body: GestureDetector(
        onTap: () {
          controller!.isGoldWithdrawPopUpShow.value = false;
          controller.isOTPPopUpShow.value = false;
          //  Close the popup when tapping outside
          if (controller!.isGoldWithdrawPopUpShow.value) {
            controller.isGoldWithdrawPopUpShow.value = false;
            controller.isOTPPopUpShow.value = false;
            controller.update();
          }
        },
        child: Obx(
          () => userManagementController!.isUserSipDetailsLoading.value
              ? const Center(
                  child: CupertinoActivityIndicator(
                  color: Colors.black,
                ))
              : SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.025,
                            width: Get.width * 0.025,
                          ),
                          Row(
                            children: [
                              SizedBox(width: Get.width * 0.015),
                              IconButton(
                                onPressed: () {
                                  controller?.newValue?.value = "";
                                  controller?.update();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                              SizedBox(width: Get.width * 0.01),
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
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                runSpacing: 10,
                                spacing: 10,
                                children: List.generate(
                                  controller!.userDetailsValue.length,
                                  (index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 80,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(controller.userDetailsValue[index]
                                            ["icon"]),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CommonText(
                                            text: controller
                                                .userDetailsValue[index]
                                                    ['title']
                                                .toString(),
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Obx(
                                          () => Flexible(
                                            child: CommonText(
                                              text: controller.userDetailsValue[
                                                      index]['totalValue'] ??
                                                  "",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.015),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                controller!.options.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    if (index == 2) {
                                      if (userManagementController
                                              .sipData
                                              ?.userWithActiveSip
                                              ?.totalGramsAccumulated ==
                                          0.000) {
                                        Get.snackbar("Error",
                                            "Insufficient Gold Balance",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            snackStyle: SnackStyle.FLOATING);
                                      } else {
                                        controller
                                                .isGoldWithdrawPopUpShow.value =
                                            !controller
                                                .isGoldWithdrawPopUpShow.value;
                                      }
                                      controller.update();
                                    } else if (index == 3) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => GetBuilder<UserAllDetailsController>(
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CommonText(
                                                    text: "Add Amount",
                                                    color: ColorHelper.brownColor,
                                                    fontSize: 16,
                                                  ),
                                                ],
                                              ),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CommonTextField(
                                                    hintText: "",
                                                    controller:
                                                        controller.amountController,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  CommonText(
                                                    text: "Add months",
                                                    color: ColorHelper.brownColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  CommonTextField(
                                                    hintText: "",
                                                    controller:
                                                        controller.monthController,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  CommonText(
                                                    text: "Add note",
                                                    color: ColorHelper.brownColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  CommonTextField(
                                                    hintText: "",
                                                    controller:
                                                        controller.noteController,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  DropdownButton<String>(
                                                    value:
                                                        controller.selectedOption,
                                                    hint: Text(controller
                                                                .selectedOption !=
                                                            null
                                                        ? controller.selectedOption
                                                            .toString()
                                                        : "Choose Payment method"),
                                                    isExpanded: true,
                                                    items: controller.paymentOptions
                                                        .map((String option) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      controller.selectedOption = value;
                                                      controller.update();
                                                    },
                                                  ),

                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.addGoldManually(
                                                        userManagementController
                                                                .sipData
                                                                ?.userWithActiveSip
                                                                ?.id ??
                                                            "");
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          ColorHelper.brownColor),
                                                  child: CommonText(
                                                    text: "Submit",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.addGoldManually(
                                                        userManagementController
                                                                .sipData
                                                                ?.userWithActiveSip
                                                                .id ??
                                                            "");
                                                    Navigator.pop(context);
                                                  },
                                                  child: CommonText(
                                                    text: "Cancel",
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ],
                                            );
                                          }
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 80,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: index == 2 || index == 3
                                          ? ColorHelper.brownColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: CommonText(
                                      text: controller.options[index]['title'],
                                      fontSize: 14,
                                      maxLines: 3,
                                      color: index == 2 || index == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// history and recent transaction part
                          // SizedBox(
                          //   height: 200,
                          //   child: Row(
                          //     children: [
                          //       Column(
                          //         children: [
                          //           CommonText(text: "Date"),
                          //           ListView.builder(
                          //             itemCount: controller
                          //                     .userDetailsController
                          //                     .sipData
                          //                     ?.sipDetails
                          //                     .first
                          //                     .transactions!
                          //                     .length ??
                          //                 0,
                          //             itemBuilder: (context, index) {
                          //               return CommonText(
                          //                   text: controller
                          //                           ?.userDetailsController
                          //                           .sipData
                          //                           ?.sipDetails
                          //                           .first
                          //                           .transactions?[index]
                          //                           .date
                          //                           .toString() ??
                          //                       "");
                          //             },
                          //           )
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      Obx(() {
                        return controller!.isGoldWithdrawPopUpShow.value
                            ? Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: Get.width * 0.4,
                                  margin: const EdgeInsets.only(top: 120),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: ColorHelper.brownColor,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              onPressed: () {
                                                controller!
                                                    .isGoldWithdrawPopUpShow
                                                    .value = false;
                                                controller.update();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Image.asset("assets/images/logo.png"),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 140,
                                        width: 320,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CommonText(
                                              text: "Available Gold Balance ",
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.grid_goldenratio,
                                                  color: ColorHelper
                                                      .goldYellowColor,
                                                ),
                                                CommonText(
                                                  text: userManagementController
                                                          .sipData
                                                          ?.userWithActiveSip
                                                          ?.totalGramsAccumulated
                                                          ?.toStringAsFixed(
                                                              3) ??
                                                      "",
                                                  fontSize: 32,
                                                  color: ColorHelper
                                                      .goldYellowColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CommonText(
                                        text: "Withdraw Gold (Enter in gm)",
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isGoldWithdrawPopUpShow
                                              .value = false;
                                          controller.isOTPPopUpShow.value =
                                              true;
                                          controller.goldWithDraw();
                                          controller.update();

                                          ///

                                          ///
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 250,
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorHelper.yellowColor,
                                          ),
                                          child: CommonText(
                                            text: "Withdraw",
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      }),
                      Obx(
                        () => controller.isOTPPopUpShow.value
                            ? Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: Get.height * 0.5,
                                  width: Get.width * 0.4,
                                  margin: const EdgeInsets.only(top: 120),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: ColorHelper.brownColor,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonText(
                                        text: "Enter OTP",
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: 250,
                                        child: CommonTextField(
                                          hintText: "Enter OTP",
                                          controller: controller.otpController,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isOTPPopUpShow.value =
                                              false;
                                          controller
                                              .goldWithDrawOtpVerification();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 250,
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorHelper.yellowColor,
                                          ),
                                          child: CommonText(
                                            text: "Withdraw",
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  });
}
