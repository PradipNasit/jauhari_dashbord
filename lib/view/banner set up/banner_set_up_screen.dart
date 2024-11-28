import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/responsive/common_builder.dart';
import 'package:jauhari_dashbord/view/banner%20set%20up/controller/banner_set_up_controller.dart';

import 'widget/pick_banner_widget.dart';

class BannerSetUpScreen extends StatelessWidget {
  BannerSetUpScreen({super.key});

  final bannerSetUpController = Get.put(BannerSetUpController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerSetUpController>(builder: (_) {
      return ResponsiveLayout(
        deskTopView: Column(
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
            pickBannerWidget(controller: bannerSetUpController)
          ],
        ),
      );
    });
  }
}
