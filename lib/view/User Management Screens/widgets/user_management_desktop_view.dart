import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_investment_.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/user_details_model.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/view/user_all_details.dart';

class UserManagementDesktopView extends StatelessWidget {
  UserManagementDesktopView({super.key});

  final userManagementController =
      Get.put(UserManagementController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.containerBgColor,
      body: Column(
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
                            onViewButtonPressed: (p0) {
                              userManagementController
                                  .getUserSipDetails(p0.id.toString());

                              // Navigate to the UserAllDetails screen after data is fetched
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => UserAllDetails(
                                    data: userManagementController.sipData,
                                    controller: userManagementController,
                                  ),
                                ),
                              );
                            },
                            onDelete: (p0) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: "Delete",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CommonText(
                                          text:
                                              "We have send you OTP on your register number")
                                    ],
                                  ),
                                  content: CommonTextField(
                                    hintText: "Enter Otp",
                                    controller:
                                        userManagementController.otpController,
                                    onChanged: (p0) {
                                      // userManagementController.otpController.text = p0;
                                      userManagementController.update();
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (userManagementController
                                            .otpController.text.isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: "Please enter the otp",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.SNACKBAR,
                                            fontSize: 14.0,
                                          );
                                        } else {
                                          userManagementController
                                              .deleteUser(p0.id.toString());
                                          Navigator.pop(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorHelper.brownColor),
                                      child: CommonText(
                                        text: "Submit",
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: CommonText(
                                        text: "cancel",
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              );
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
