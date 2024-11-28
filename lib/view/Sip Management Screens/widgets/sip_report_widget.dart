import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/Sip%20Management%20Screens/controller/sip_management_controller.dart';

class SipReportWidget extends StatelessWidget {
  SipManagementController sipManagementController;
   SipReportWidget({super.key , required this.sipManagementController});

  @override
  Widget build(BuildContext context) {

    return   Obx(
      () =>  sipManagementController.isSipDataLoading.value == true ? const  CupertinoActivityIndicator() :Column(
        children: [
          SizedBox(height: Get.height * 0.05  ,),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runSpacing: 10,
            spacing: 10,
            children: List.generate(
              sipManagementController.sipReportData().length,
                  (index) {
                    final reportData = sipManagementController.sipReportData();
                return  GestureDetector(
                  onTap: () {
                    sipManagementController.selectedIndex.value = index;

                    switch (index) {
                      case 0:
                        SipReportWidget(sipManagementController: sipManagementController,);
                      default:
                        'No view available';
                    }

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    height: 85,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: CommonText(
                              text: reportData[index]
                              ['title'],
                              fontSize: 16,
                              maxLines: 1,
                            )),
                        const Spacer(),
                        CommonText(
                          text: reportData[index]
                          ['total'].toString(),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                );
                  }
            ),
          ),
        ],
      ),
    );
  }
}
