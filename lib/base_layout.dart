import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/responsive/common_builder.dart';
import 'package:jauhari_dashbord/view/HomeScreen/controller/home_controller.dart';
import 'package:jauhari_dashbord/view/HomeScreen/page/home_page.dart';

class BaseLayout extends StatefulWidget {
  final Widget content;

  BaseLayout({required this.content});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: ColorHelper.containerBgColor,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sidebar
              Container(
                height: Get.height,
                width: 250,
                color: ColorHelper.brownColor,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        homeController.sideBarOptions.length,
                            (index) => GestureDetector(
                          onTap: () {

                               homeController.selectedIndex.value = index;
                              homeController.update();
                              Get.off(HomePage());

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: homeController.selectedIndex.value == index? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: CommonText(
                                text: homeController.sideBarOptions[index]['title'],
                                fontSize: 16,
                                color:homeController.selectedIndex.value == index? Colors.black :Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content area
              Expanded(
                child: ResponsiveLayout(deskTopView: widget.content),
              ),
            ],
          ),
        );
      }
    );
  }
}
