import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/responsive/common_builder.dart';
import 'package:jauhari_dashbord/view/HomeScreen/controller/home_controller.dart';
import 'package:jauhari_dashbord/view/HomeScreen/page/home_page.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/widgets/user_management_desktop_view.dart';
import 'package:jauhari_dashbord/view/notification/notification_screen.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/view/user_all_details.dart';

import 'view/Business set up/business_set_up_screen.dart';
import 'view/banner set up/banner_set_up_screen.dart';
import 'view/social media/social_media_screen.dart';

class BaseLayout extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const BaseLayout({super.key, required this.navigatorKey});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (_) {
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
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      homeController.sideBarOptions.length,
                          (index) => GestureDetector(
                        onTap: () {
                          homeController.selectedIndex.value = index;
                          homeController.update();

                          // Navigate to the selected page
                          widget.navigatorKey.currentState?.pushReplacementNamed(
                              homeController.sideBarOptions[index]['route']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color:
                                homeController.selectedIndex.value == index
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  homeController.sideBarOptions[index]['icon'],
                                  color: homeController.selectedIndex.value ==
                                      index
                                      ? ColorHelper.brownColor
                                      : Colors.white,
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: CommonText(
                                    text: homeController.sideBarOptions[index]
                                    ['title'],
                                    fontSize: 16,
                                    maxLines: 1,
                                    color: homeController.selectedIndex.value ==
                                        index
                                        ? ColorHelper.brownColor
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content area with Nested Navigator
            Expanded(
              child: Navigator(
                key: widget.navigatorKey,
                initialRoute: '/home',
                onGenerateRoute: (settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/home':
                      builder = (BuildContext _) => HomePage();
                      break;
                    case '/userManagement':
                      builder = (BuildContext _) => UserManagementDesktopView();
                      break;

                    case '/businessSetup':
                      builder = (BuildContext _) => BusinessSetUpScreen();
                      break;

                    case '/Pages and Media':
                      builder = (BuildContext _) => SocialMediaScreen();
                      break;

                    case '/bannerSetup':
                      builder = (BuildContext _) => BannerSetUpScreen();
                      break;

                    case '/notifications':
                      builder = (BuildContext _) => NotificationScreen();
                      break;

                    case '/user-details':
                      final args = settings.arguments as Map<String, dynamic>;
                      builder = (BuildContext _) => UserAllDetails(
                        data: args['data'],
                        controller: args['controller'],
                      );
                      break;

                    default:
                      builder = (BuildContext _) => const Center(child: Text('No view available'));
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
