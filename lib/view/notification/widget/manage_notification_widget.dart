import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/notification/controller/notification_controller.dart';


Widget manageNotificationWidget({required NotificationController controller , required BuildContext context}) {
  
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  
  return Container(
    height: height,
    width: width,
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const   SizedBox(height: 20),
        Text("Notifications", style: TextStyle(fontSize: 16, color: ColorHelper.brownColor)),
        const   SizedBox(height: 10),
        Divider(),
        const   SizedBox(height: 16),
        Obx(
          ()=> Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: [
                          CommonText(text: "Gold Scheme Confirmation Message",color: ColorHelper.brownColor,),
                          SizedBox(width: width *0.07,),
                          Transform.scale(
                            scale: 0.8, // A
                            child: Switch(value: controller.switchValue.value, onChanged: (value) {
                              controller.switchValue.value = value;
                              controller.update();
                            },),
                          )
                        ],
                      ),
                      Container(
                        height: 151,
                        width: 400,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorHelper.brownColor, width: 1.0),
                        ),
                        child: TextField(
                          maxLines: null, // Allows multi-line input
                          expands: true, // Makes the TextField expand to fit the container
                          textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the default border
                            hintText: "Write here...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonText(text: "Gold Scheme Confirmation Message",color: ColorHelper.brownColor,),
                          SizedBox(width: width *0.07,),
                          Transform.scale(
                            scale: 0.8, // A
                            child: Switch(value: controller.switchValue.value, onChanged: (value) {
                              controller.switchValue.value = value;
                              controller.update();
                            },),
                          )
                        ],
                      ),
                      Container(
                        height: 151,
                        width: 400,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorHelper.brownColor, width: 1.0),
                        ),
                        child: TextField(
                          maxLines: null, // Allows multi-line input
                          expands: true, // Makes the TextField expand to fit the container
                          textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the default border
                            hintText: "Write here...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonText(text: "Gold Scheme Confirmation Message",color: ColorHelper.brownColor,),
                          SizedBox(width: width *0.07,),
                          Transform.scale(
                            scale: 0.8, // A
                            child: Switch(value: controller.switchValue.value, onChanged: (value) {
                              controller.switchValue.value = value;
                              controller.update();
                            },),
                          )
                        ],
                      ),
                      Container(
                        height: 151,
                        width: 400,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorHelper.brownColor, width: 1.0),
                        ),
                        child: TextField(
                          maxLines: null, // Allows multi-line input
                          expands: true, // Makes the TextField expand to fit the container
                          textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the default border
                            hintText: "Write here...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )

                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonText(text: "Gold Scheme Confirmation Message",color: ColorHelper.brownColor,),
                          SizedBox(width: width *0.07,),
                          Transform.scale(
                            scale: 0.8, // A
                            child: Switch(value: controller.switchValue.value, onChanged: (value) {
                              controller.switchValue.value = value;
                              controller.update();
                            },),
                          )
                        ],
                      ),
                      Container(
                        height: 151,
                        width: 400,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorHelper.brownColor, width: 1.0),
                        ),
                        child: TextField(
                          maxLines: null, // Allows multi-line input
                          expands: true, // Makes the TextField expand to fit the container
                          textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the default border
                            hintText: "Write here...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonText(text: "Gold Scheme Confirmation Message",color: ColorHelper.brownColor,),    SizedBox(width: width *0.07,),

                          Transform.scale(
                            scale: 0.8, // A
                            child: Switch(value: controller.switchValue.value, onChanged: (value) {
                              controller.switchValue.value = value;
                              controller.update();
                            },),
                          )
                        ],
                      ),
                      Container(
                        height: 151,
                        width: 400,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorHelper.brownColor, width: 1.0),
                        ),
                        child: TextField(
                          maxLines: null, // Allows multi-line input
                          expands: true, // Makes the TextField expand to fit the container
                          textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the default border
                            hintText: "Write here...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonText(text: "Gold Scheme Confirmation Message",color: ColorHelper.brownColor,),
                          SizedBox(width: width *0.07,),
                          Transform.scale(
                            scale: 0.8, // A
                            child: Switch(value: controller.switchValue.value, onChanged: (value) {
                              controller.switchValue.value = value;
                              controller.update();
                            },),
                          )
                        ],
                      ),
                      Container(
                        height: 151,
                        width: 400,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorHelper.brownColor, width: 1.0),
                        ),
                        child: TextField(
                          maxLines: null, // Allows multi-line input
                          expands: true, // Makes the TextField expand to fit the container
                          textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the default border
                            hintText: "Write here...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  
  );
}