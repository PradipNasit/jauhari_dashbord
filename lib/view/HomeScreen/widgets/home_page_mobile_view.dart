import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/HomeScreen/controller/home_controller.dart';

class HomePageMobileView extends StatelessWidget {
  HomeScreenController controller;
   HomePageMobileView({super.key , required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CommonTextField(hintText: "Search"),
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
                          controller.homeOptions.length,
                              (index) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 85,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person_2_outlined,
                                ),
                              const   SizedBox(width: 10,),
                                Expanded(
                                    child: CommonText(
                                      text: controller.homeOptions[index]['title'],
                                      fontSize: 16,
                                      maxLines: 1,
                                    )),
                                const Spacer(),
                                CommonText(
                                  text: controller.homeOptions[index]
                                  ['totalValue'] ,fontSize: 22,fontWeight: FontWeight.w700,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
