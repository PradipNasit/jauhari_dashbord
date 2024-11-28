import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/base_layout.dart';
import 'package:jauhari_dashbord/common/common_investment_.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/user_details_model.dart';

class UserManagementDesktopView extends StatelessWidget {
  UserManagementDesktopView({super.key});

  final userManagementController = Get.put(UserManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.containerBgColor,
      body:     Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: Get.width * 0.015),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: CommonTextField(
                            hintText: "Search",
                            controller:
                            userManagementController.userSearchController,
                            onChanged: (p0) {
                              userManagementController.filterUser(
                                  userManagementController
                                      .userSearchController.text);
                              userManagementController.update();
                            },
                          )),
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
                        () => userManagementController.userDataLoading.value
                        ? const Center(child: CupertinoActivityIndicator())
                        : DynamicTable<UserDetails>(
                      editingRowIndex:
                      userManagementController.editingRowIndex,
                      headers: const [
                        "User name",
                        "Pan card no.",
                        "Mobile",
                        "Email id",
                      ],
                      data: userManagementController.useDetails,
                      onChanged: [
                            (user, index, value) {
                          userManagementController.fullNameCtr.text =
                              value;
                        },
                            (user, index, value) {
                          userManagementController.panCardCtr.text =
                              value;
                        },
                            (user, index, value) {
                          userManagementController.mobileNumberCtr.text =
                              value;
                        },
                            (user, index, value) {
                          userManagementController.emailctr.text = value;
                        },
                      ],
                      onDelete: (p0) {
                        userManagementController
                            .deleteUser(p0.id.toString());
                      },
                      onEdit: (p0) {
                        userManagementController.editUserData(p0.id);
                      },
                      valueExtractors: [
                            (item) => item.fullName,
                            (item) => item.panCard.toString(),
                            (item) => item.mobileNumber.toString(),
                            (item) => item.email,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),



    );
  }
}
