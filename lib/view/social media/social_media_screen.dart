import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/social%20media/controller/social_media_controller.dart';

import 'widget/faq_widget.dart';
import 'widget/social_media_link_widget.dart';

class SocialMediaScreen extends StatelessWidget {
  SocialMediaScreen({super.key});

  final socialMediaController = Get.put(SocialMediaController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (_) {
      return DefaultTabController(
        length: 7,
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
                TabBar(tabs: [
                  CommonText(text: "Terms and Conditions"),
                  CommonText(text: "Privacy Policy"),
                  CommonText(text: "Cancellation Policy"),
                  CommonText(text: "Refund & Return Policy"),
                  CommonText(text: "About Us"),
                  CommonText(text: "FAQ"),
                  CommonText(text: "Social Media Links"),
                ]),
                SizedBox(
                  height: Get.height,
                  child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          Container(
                            height: 300, // Increase height
                            width: double.infinity, // Take full width
                            padding: const EdgeInsets.all(10), // Add padding
                            decoration: BoxDecoration(
                              color: Colors.white, // Add a background color
                              border: Border.all(
                                  color: Colors.grey), // Add a border
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: QuillEditor(
                              controller: socialMediaController.tAndCController,
                              scrollController: ScrollController(),
                              focusNode: FocusNode(),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          QuillToolbar.simple(
                              controller:
                                  socialMediaController.tAndCController),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              socialMediaController.createTermAndCondition();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorHelper.brownColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(
                                () => socialMediaController
                                        .isTermAndConditionLoading.value
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : CommonText(
                                        text: "Submit",
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          Container(
                            height: 300, // Increase height
                            width: double.infinity, // Take full width
                            padding: const EdgeInsets.all(10), // Add padding
                            decoration: BoxDecoration(
                              color: Colors.white, // Add a background color
                              border: Border.all(
                                  color: Colors.grey), // Add a border
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: QuillEditor(
                              controller:
                                  socialMediaController.privacyPolicyController,
                              scrollController: ScrollController(),
                              focusNode: FocusNode(),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          QuillToolbar.simple(
                              controller: socialMediaController
                                  .privacyPolicyController),

                          GestureDetector(
                            onTap: () {
                              socialMediaController.createPrivacyPolicy();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorHelper.brownColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(
                                () => socialMediaController
                                        .isPrivacyPolicyLoading.value
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : CommonText(
                                        text: "Submit",
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          Container(
                            height: 300, // Increase height
                            width: double.infinity, // Take full width
                            padding: const EdgeInsets.all(10), // Add padding
                            decoration: BoxDecoration(
                              color: Colors.white, // Add a background color
                              border: Border.all(
                                  color: Colors.grey), // Add a border
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: QuillEditor(
                              controller: socialMediaController
                                  .cancellationPolicyController,
                              scrollController: ScrollController(),
                              focusNode: FocusNode(),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          QuillToolbar.simple(
                              controller: socialMediaController
                                  .cancellationPolicyController),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              socialMediaController.createCancellationPolicy();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorHelper.brownColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(
                                () => socialMediaController
                                        .isCancellationPolicyLoading.value
                                    ? CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : CommonText(
                                        text: "Submit",
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          Container(
                            height: 300, // Increase height
                            width: double.infinity, // Take full width
                            padding: const EdgeInsets.all(10), // Add padding
                            decoration: BoxDecoration(
                              color: Colors.white, // Add a background color
                              border: Border.all(
                                  color: Colors.grey), // Add a border
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: QuillEditor(
                              controller: socialMediaController
                                  .refundAndReturnController,
                              scrollController: ScrollController(),
                              focusNode: FocusNode(),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          QuillToolbar.simple(
                              controller: socialMediaController
                                  .refundAndReturnController),
                          const SizedBox(
                              height: 20),
                          GestureDetector(
                            onTap: () {
                              socialMediaController.createReturnAndRefund();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorHelper.brownColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(
                                    () => socialMediaController
                                    .isReturnAndRefundLoading.value
                                    ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                                    : CommonText(
                                  text: "Submit",
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          Container(
                            height: 300, // Increase height
                            width: double.infinity, // Take full width
                            padding: const EdgeInsets.all(10), // Add padding
                            decoration: BoxDecoration(
                              color: Colors.white, // Add a background color
                              border: Border.all(
                                  color: Colors.grey), // Add a border
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: QuillEditor(
                              controller:
                                  socialMediaController.aboutUsController,
                              scrollController: ScrollController(),
                              focusNode: FocusNode(),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add spacing for better visibility
                          QuillToolbar.simple(
                              controller:
                                  socialMediaController.aboutUsController),
                        ],
                      ),
                    ),
                    faqWidget(
                        controller: socialMediaController, context: context),
                    socialMediaLinksWidget(
                        context: context, controller: socialMediaController)
                  ]),
                )
              ],
            ),
          ),
        ),
      );
    });
    ;
  }
}
