import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/social%20media/controller/social_media_controller.dart';

Widget socialMediaLinksWidget({required BuildContext context , required SocialMediaController controller}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Column(
    children: [
      Container(
        width: width,
        height: 330,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            CommonText(
              text: "Social Media Links",
              color: ColorHelper.brownColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            CommonTextField(hintText: "Enter Platform here " ,controller: controller.platFormController,),
            const SizedBox(
              height: 20,
            ),
            CommonText(
              text: "Social Media Link",
              color: ColorHelper.brownColor,
            ),
           const  SizedBox(
              height: 10,
            ),
            CommonTextField(hintText: "Enter Url Here" , controller: controller.platLinkController,),
            GestureDetector(
              onTap: () {
                controller.createSocialMedia();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 50,
                  width: 190,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      color: ColorHelper.brownColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: controller.isSignInLoading.value ? const CupertinoActivityIndicator(color: Colors.white,) :CommonText(
                    text: "Save",
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
