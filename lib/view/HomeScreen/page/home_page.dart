import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/view/HomeScreen/controller/home_controller.dart';
import 'package:jauhari_dashbord/view/HomeScreen/widgets/home_page_desktop_view.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.put(HomeScreenController());
  Type? currentControllerType = HomeScreenController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (_) {
      return HomePageDesktopView(controller: homeController);
    });
  }
}
