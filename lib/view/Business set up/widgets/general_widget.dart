import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_colum_widget.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/Business%20set%20up/controller/business_set_up_controller.dart';

Widget generalWidget(
    {required BusinessSetUpController controller,
    required BuildContext context}) {
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
  return GetBuilder<BusinessSetUpController>(builder: (_) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorHelper.brownColor),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: "Maintenance mode",
                    color: ColorHelper.brownColor,
                    fontSize: 16,
                  ),
                  Switch(
                    value: controller.switchValue.value ?? false,
                    activeColor: ColorHelper.brownColor,
                    onChanged: (value) {
                      controller.switchValue.value = value;
                      controller.update();
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(26),
              margin: const EdgeInsets.only(top: 40, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home_work_outlined,
                        color: ColorHelper.brownColor,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      CommonText(
                        text: "Company Information",
                        color: ColorHelper.brownColor,
                        fontSize: 16,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonColumnWidgets(
                          title: "Company Name",
                          context: context,
                          hintText: "",
                          controller: controller.companyName),
                      commonColumnWidgets(
                          title: "Phone",
                          context: context,
                          hintText: "",
                          controller: controller.companyPhone),
                      commonColumnWidgets(
                          title: "Email",
                          context: context,
                          hintText: "",
                          controller: controller.companyEmail),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonColumnWidgets(
                          title: "Country",
                          context: context,
                          hintText: "",
                          controller: controller.country),
                      commonColumnWidgets(
                          title: "Time Zone",
                          context: context,
                          hintText: "",
                          controller: controller.timeZone),
                      commonColumnWidgets(
                          title: "Language",
                          context: context,
                          hintText: "",
                          controller: controller.language),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      commonColumnWidgets(
                          title: "Company Address",
                          context: context,
                          hintText: "",
                          controller: controller.companyAddress),
                      const SizedBox(
                        width: 25,
                      ),
                      commonColumnWidgets(
                          title: "Company Copyright Text",
                          context: context,
                          hintText: "",
                          controller: controller.copyRightText),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                   () =>  GestureDetector(
                      onTap: () {
                        controller.createBusiness();
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorHelper.brownColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: controller.isSignInLoading.value ? CupertinoActivityIndicator(color: Colors.white, ) :CommonText(text: "Submit",color: Colors.white,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  });
}
