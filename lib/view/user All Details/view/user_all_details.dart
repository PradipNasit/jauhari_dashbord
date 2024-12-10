import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/user_sip_model.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/controller/user_all_details_controller.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/widgets/user_all_details_desktop_view.dart';

class UserAllDetails extends StatelessWidget {
  UserSIpData? data;
  UserManagementController? controller;

  UserAllDetails({super.key, this.data, this.controller});

  final userDetailsAllController = Get.put(UserAllDetailsController());

  @override
  Widget build(BuildContext context) {
    return userAllDetailsDesktopView(
        controller: userDetailsAllController,
        context: context,
        userManagementController: controller);
  }
}
