import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/responsive/common_builder.dart';
import 'package:jauhari_dashbord/view/Business%20set%20up/business_set_up_screen.dart';
import 'package:jauhari_dashbord/view/HomeScreen/model/request/creatre_sip_request.dart';
import 'package:jauhari_dashbord/view/HomeScreen/model/response/get_dashbord_data_model.dart';
import 'package:jauhari_dashbord/view/HomeScreen/widgets/home_page_desktop_view.dart';
import 'package:jauhari_dashbord/view/Sip%20Management%20Screens/widgets/sip_management_desktop_view.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/widgets/user_management_desktop_view.dart';
import 'package:jauhari_dashbord/view/banner%20set%20up/banner_set_up_screen.dart';
import 'package:jauhari_dashbord/view/notification/notification_screen.dart';
import 'package:jauhari_dashbord/view/social%20media/social_media_screen.dart';

class HomeScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;
  GetDashBordDataModel? dashBordModel;

  RxBool isDashBordDataLoading = false.obs;

  final sipAmount = TextEditingController();

  List<Map<String, dynamic>> get homeOptions {
    return [
      {
        "title": "Total Users",
        "icon": Icons.person,
        "totalValue": dashBordModel?.totalUsers.toString() ?? "0",
      },
      {
        "title": "Active SIPs",
        "icon": Icons.sip_outlined,
        "totalValue": dashBordModel?.activeSiPs.toString() ?? "0",
      },
      {
        "title": "Completed SIPs",
        "icon": Icons.sip,
        "totalValue": dashBordModel?.completedSiPs.toString() ?? "0",
      },
      {
        "title": "Total Payment",
        "icon": Icons.currency_rupee,
        "totalValue": double.parse(dashBordModel?.totalPayments?.amount.toString() ?? "0.0")
            .toStringAsFixed(2),
      },
      {
        "title": "Missed Payments",
        "icon": Icons.warning, // Use a valid fallback icon
        "totalValue": "12",
      },
      {
        "title": "Total Gold Accumulated",
        "icon": Icons.currency_rupee,
        "totalValue": double.parse(dashBordModel?.totalGoldAccumulated?.toStringAsFixed(3) ?? "0.0")
            .toStringAsFixed(2),
      },
    ];
  }


  buildResponsiveView(int option, HomeScreenController controller) {
    switch (option) {
      case 0:
        return ResponsiveLayout(
          deskTopView: HomePageDesktopView(controller: controller),
          // mobileView: HomePageMobileView(controller: controller),
        );
      case 1:
        // deletePreviousController(UserManagementController);
        return ResponsiveLayout(
          deskTopView: UserManagementDesktopView(),
          // mobileView: UserManagementMobileView(),
        );

      case 3:
        return ResponsiveLayout(deskTopView: BusinessSetUpScreen());
      case 4:
        return ResponsiveLayout(deskTopView: SocialMediaScreen());

      case 5:
        return ResponsiveLayout(deskTopView: BannerSetUpScreen());
      case 6:
        return ResponsiveLayout(deskTopView: NotificationScreen());

      default:
        return const Center(child: Text('No view available'));
    }
  }

  List<Map<String, dynamic>> sideBarOptions = [
    {"title": "Dashboard" , "icon":"assets/icons/dashbord_icon.svg" , "route": "/home"},
    {"title": "User Management", "icon":"assets/icons/user_man_icon.svg" , "route": "/userManagement"},
    {"title": "Recent Transactions", "icon":"assets/icons/rec_tran_icon.svg" , "route": "/recentTransactions"},
    {"title": "Business Setup", "icon":"assets/icons/busimess_icon.svg",  "route": "/businessSetup"},
    {"title": "Pages and Media", "icon":"assets/icons/pages_media_icon.svg" , "route": "/Pages and Media"},
    {"title": "Banner Setup", "icon":"assets/icons/banner_set_icon.svg",  "route": "/bannerSetup"},
    {"title": "Notifications", "icon":"assets/icons/noti_icon.svg","route": "/notifications"},
  ];

  final box = GetStorage();

  CreateSipRequestModel createSipRequestData() {
    return CreateSipRequestModel(monthlyAmount: int.parse(sipAmount.text));
  }

  Future<void> getDashBordData() async {
    final token = box.read("token");
    isDashBordDataLoading.value = true;
    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.getDashBordData,
        requestType: RequestType.GET,
        headers: {"Authorization": "Bearer $token"});
    isDashBordDataLoading.value = false;
    if (response?.statusCode == 200) {
      dashBordModel = GetDashBordDataModel.fromJson(jsonDecode(response!.body));


    }
  }

  Future<void> createSipPlans() async {
    final token = box.read("token");

    final creteSipData = createSipRequestData();
    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.createSip,
        requestType: RequestType.POST,
        headers: {"Authorization": "Bearer $token"},
        body: creteSipData.toJson());

    log(name: "createSipStatusCode", response!.statusCode.toString());
    log(name: "createSipResponse", response!.body.toString());

    if (response?.statusCode == 200) {}
  }


}
