import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/view/HomeScreen/controller/home_controller.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.put(HomeScreenController());
  Type? currentControllerType = HomeScreenController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (_) {
      return BaseLayout(
          content: homeController.buildResponsiveView(
              homeController.selectedIndex.value, homeController));
    });
  }
}
