import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/banner%20set%20up/controller/banner_set_up_controller.dart';



Widget pickBannerWidget({required BannerSetUpController controller}) {
  return Flexible(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Form

            Container(
              height: 380,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Banner Form",
                      style: TextStyle(
                          fontSize: 16, color: ColorHelper.brownColor)),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 450,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorHelper.brownColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          items: ["Main Banner", "Side Banner", "Footer Banner"]
                              .map((type) => DropdownMenuItem(
                                  value: type, child: Text(type)))
                              .toList(),
                          value: controller.selectedBannerType.value.isEmpty
                              ? null
                              : controller.selectedBannerType.value,
                          onChanged: (value) =>
                              controller.selectedBannerType.value = value ?? '',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                          ),
                          hint: const Text(
                            "Select Banner Type",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Obx(
                       () =>  GestureDetector(
                          onTap: controller.pickFile,
                          child: Container(
                              height: 150,
                              width: Get.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorHelper.brownColor),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: controller.selectedFile.value != null
                                  ? Image.memory(controller.selectedFile.value!,fit: BoxFit.contain,)
                                  : Center(
                                    child: CommonText(
                                        text: "Please Select a file",
                                        color: ColorHelper.brownColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  )),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedBannerType.value.isNotEmpty &&
                              controller.selectedFile.value != null) {

                            controller.uploadFile(controller.selectedFile.value!, controller.fileName.value);
                            controller.addBanner(
                              controller.selectedBannerType.value,
                              controller.selectedFile.value,
                            );
                          } else {
                            Get.snackbar("Error", "Please fill in all fields");
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorHelper.brownColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: CommonText(
                            text: "Save",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: controller.resetForm,
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorHelper.brownColor),
                              borderRadius: BorderRadius.circular(12)),
                          child: CommonText(
                            text: "Reset",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Banner Table
            const SizedBox(height: 30),
            const Text("Banner Table",
                style: TextStyle(fontSize: 16, color: ColorHelper.brownColor)),
            const Divider(),
            const SizedBox(height: 16),
           const  SizedBox(height: 10),
            Obx(() {
              return controller.isBannerLoading.value ?const  CupertinoActivityIndicator() :ListView.builder(
                itemCount: controller.bannerShortData.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final banner = controller.bannerShortData[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.network(banner.bannerUrl ??"",
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(banner.bannerType.toString()),
                      subtitle: Text(
                          "Published: ${banner.status ? 'Yes' : 'No'}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: banner.status,
                            onChanged: (value) =>
                                controller.togglePublishStatus(index),
                          ),
                          IconButton(
                            onPressed: () => controller.deleteBanner(index),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    ),
  );
}
