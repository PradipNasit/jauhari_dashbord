import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/HomeScreen/controller/home_controller.dart';

class HomePageDesktopView extends StatelessWidget {
  HomeScreenController controller;
  HomePageDesktopView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.02,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Row(
                        children: [
                          Flexible(child: CommonTextField(hintText: "Search")),
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
                      Obx(
                        () => controller.isDashBordDataLoading.value
                            ? const Center(child: CupertinoActivityIndicator())
                            : Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                runSpacing: 10,
                                spacing: 10,
                                children: List.generate(
                                  controller.homeOptions.length,
                                  (index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 85,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      children: [
                                         Icon(
                                          controller.homeOptions[index]
                                          ["icon"],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: CommonText(
                                          text: controller.homeOptions[index]
                                              ['title'],
                                          fontSize: 16,
                                          maxLines: 1,
                                        )),
                                        const Spacer(),
                                        CommonText(
                                          text: controller.homeOptions[index]
                                              ['totalValue'],
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
