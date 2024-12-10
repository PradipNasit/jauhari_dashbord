import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/social%20media/controller/social_media_controller.dart';

Widget faqWidget(
    {required SocialMediaController controller,
    required BuildContext context}) {
  return Obx(
   () => controller.isGetFaq.value ? const CupertinoActivityIndicator(color: Colors.black,) :Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Help Topic Table",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.isFaqPopUpShow.value =
                        !controller.isFaqPopUpShow.value;
                    controller.update();
                    // Add your logic for adding FAQs
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add FAQ",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorHelper.brownColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                const Text("Search: "),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Keywords",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                    ),
                    onChanged: controller.searchFAQ,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
        
        
        
            Obx(() => controller.isFaqPopUpShow.value
                ? Container(
                    height: 280,
                    width: Get.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Question",
                          color: ColorHelper.brownColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          hintText: "",
                          controller: controller.questionController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonText(
                          text: "Answer",
                          color: ColorHelper.brownColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          hintText: "",
                          controller: controller.answerController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.createFaq();
                          },
                          child: Container(
                            height: 45,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorHelper.brownColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Obx(() => controller.isFaqLoading.value
                                ? const CupertinoActivityIndicator(color: Colors.white,)
                                : CommonText(
                                    text: "Submit",
                                    color: Colors.white,
                                  )),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox()),
        
        
        
            const SizedBox(height: 20),
          Wrap(
              alignment: WrapAlignment.start,
              spacing: 16, // Horizontal spacing between containers
              runSpacing: 16,
            children: List.generate(controller.filteredList.length, (index) {
            return Container(
              width: Get.width / 3,
              padding:const  EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: controller.filteredList[index].question,fontSize: 16,fontWeight: FontWeight.w600,maxLines: 5,),
                  SizedBox(height: 6,),
                  CommonText(text: controller.filteredList[index].answer,fontSize: 16,maxLines: 6,),
                ],
              ),
        
            );
          },),)
          ],
        ),
      ),
    ),
  );
}
