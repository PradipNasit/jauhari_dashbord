import 'package:flutter/material.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/view/user%20All%20Details/controller/user_all_details_controller.dart';

Widget TransactionHistory({UserAllDetailsController? controller}) {
  return Flexible(
    child: Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CommonText(text: "Date"),
                ListView.builder(
                  itemCount: controller?.userDetailsController.sipData?.sipDetails
                      .first.transactions?.length,
                  itemBuilder: (context, index) {
                    return CommonText(
                        text: controller?.userDetailsController.sipData
                                ?.sipDetails.first.transactions?[index].date
                                .toString() ??
                            "");
                  },
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
