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

            SizedBox(height: Get.height * 0.02),
            pickBannerWidget(controller: bannerSetUpController)
          ],
        ),
      );
    });
  }
}
