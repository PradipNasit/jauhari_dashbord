import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:jauhari_dashbord/payment_info_model.dart';

class PaymentInfoScreen extends StatefulWidget {
  const PaymentInfoScreen({super.key});

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  final box = GetStorage();
  List<PaymentInfoModel>? data;

  bool isApiCalling = false;

  Future getPaymentInfo() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await CommonApiService.request(
      url: "http://46.202.163.138:5000/api/get/paymentConfirmation",
      requestType: RequestType.GET,
      headers: {"Authorization": "Bearer ${box.read("token")}"},
    );

    if (response?.statusCode == 200) {
      setState(() {
        isApiCalling = false;
        data = paymentInfoModelFromJson(response!.body);
      });
    } else {
      setState(() {
        isApiCalling = false;
      });
    }
  }

  @override
  void initState() {
    getPaymentInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CommonText(
          text: "Payment Info",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: ColorHelper.brownColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isApiCalling
          ? const CircularProgressIndicator()
          : ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero ,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 400,
                            width: 400,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data?[index].screenShot ?? ""))),
                          ),
                        ],
                      ),
                    );
                  },);
                },
                child: Container(
                  margin:const  EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    data?[index].screenShot.toString() ??
                                        ""),fit: BoxFit.fill)),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        CommonText(text: "UPI id :- ${data?[index].upiId ?? " "}",fontSize: 16,fontWeight: FontWeight.w500,),
                        CommonText(text: data?[index].userId?.id ?? "",fontSize: 16,fontWeight: FontWeight.w500,),
                        CommonText(text: data?[index].userId?.fullName ?? "",fontSize: 16,fontWeight: FontWeight.w500,),
                      ],)
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
