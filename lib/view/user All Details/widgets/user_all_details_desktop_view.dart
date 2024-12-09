import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/user_sip_model.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/controller/user_all_details_controller.dart';

Widget userAllDetailsDesktopView(
    {UserAllDetailsController? controller,
    required BuildContext context,
    UserSIpData? data,
    UserManagementController? userManagementController}) {
  return Scaffold(
    backgroundColor: ColorHelper.containerBgColor,
    body: GestureDetector(
      onTap: () {
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
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              controller!.userDetailsValue().length,
                              (index) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 80,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.person_2_outlined),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CommonText(
                                        text: controller
                                            .userDetailsValue()[index]['title']
                                            .toString(),
                                        fontSize: 14,
                                        maxLines: 3,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    CommonText(
                                      text: controller
                                          .userDetailsValue()[index]
                                              ['totalValue']
                                          .toString(),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
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
                              controller.options.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  controller.isGoldWithdrawPopUpShow.value =
                                      !controller.isGoldWithdrawPopUpShow.value;
                                  controller.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 80,
                                  width: 300,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: CommonText(
                                    text: controller.options[index]['title'],
                                    fontSize: 14,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      return controller!.isGoldWithdrawPopUpShow.value
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: Get.width * 0.4,
                                margin: EdgeInsets.only(top: 120),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                decoration: const BoxDecoration(
                                  color: ColorHelper.brownColor,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("assets/images/logo.png"),
                                    const SizedBox(height: 20),
                                    Container(
                                      height: 140,
                                      width: 320,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
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
                                                color:
                                                    ColorHelper.goldYellowColor,
                                              ),
                                              CommonText(
                                                text: userManagementController
                                                        .sipData
                                                        ?.user
                                                        ?.totalGramsAccumulated
                                                        ?.toStringAsFixed(3) ??
                                                    "",
                                                fontSize: 32,
                                                color:
                                                    ColorHelper.goldYellowColor,
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
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 250,
                                      child: CommonTextField(
                                        hintText: "Enter weight",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.isGoldWithdrawPopUpShow
                                            .value = false;
                                        controller.isOTPPopUpShow.value = true;
                                        controller.update();

                                        ///

                                        ///
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 250,
                                        margin: const EdgeInsets.only(top: 15),
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
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.isOTPPopUpShow.value = false;
                                        controller.goldWithDraw();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 250,
                                        margin: const EdgeInsets.only(top: 15),
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
                          : SizedBox(),
                    )
                  ],
                ),
              ),
      ),
    ),
  );
}
