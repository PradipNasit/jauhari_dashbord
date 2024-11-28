import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_field.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/social%20media/controller/social_media_controller.dart';


Widget faqWidget({
  required SocialMediaController controller,
  required BuildContext context
}){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Help Topic Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               const  Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.isFaqPopUpShow.value = true;
                    controller.update();
                    // Add your logic for adding FAQs
                  },
                  icon:const  Icon(Icons.add,color: Colors.white,),
                  label: const Text("Add FAQ",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.brownColor),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Show"),
               const  SizedBox(width: 10),
                DropdownButton<int>(
                  value: 10,
                  items: [5, 10, 20].map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                  onChanged: (value) {
                    // Handle dropdown change
                  },
                ),
               const  Spacer(),
                const Text("Search: "),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Keywords",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                    ),
                    onChanged: controller.searchFAQ,
                  ),
                ),
              ],
            ),
           const  SizedBox(height: 20),

          ],
        ),
        Obx(() {
          return controller!.isFaqPopUpShow.value
              ? Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Get.width * 0.4,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: ColorHelper.brownColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(height: 20),
                  Container(
                    height: 140,
                    width: 320,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: "Available Gold Balance ",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.grid_goldenratio,
                              color: ColorHelper.goldYellowColor,
                            ),
                            CommonText(
                              text: "5.8 Gm",
                              fontSize: 32,
                              color: ColorHelper.goldYellowColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonText(
                    text: "Withdraw Gold (Enter in gm)",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width : 250,
                    child: CommonTextField(
                      hintText: "Enter weight",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                      ///

                      ///
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      margin: const EdgeInsets.only(top: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorHelper.yellowColor,
                      ),
                      child: CommonText(
                        text: "Withdraw",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
              : const SizedBox();
        }),
      ],
    ),
  );
}
// Show Edit Dialog
void _showEditDialog(BuildContext context, SocialMediaController controller, int index) {
  final TextEditingController questionController = TextEditingController(text: controller.filteredList[index]["question"]);
  final TextEditingController answerController = TextEditingController(text: controller.filteredList[index]["answer"]);

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text("Edit FAQ"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: "Answer"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.editFAQ(
                index,
                questionController.text,
                answerController.text,
              );
              Navigator.of(ctx).pop();
            },
            child:const  Text("Save"),
          ),
        ],
      );
    },
  );
}
