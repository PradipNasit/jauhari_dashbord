import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/Sip%20Management%20Screens/model/response/get_sip_data_model.dart';
import 'package:jauhari_dashbord/view/Sip%20Management%20Screens/model/response/sip_details_model.dart';

class SipManagementController extends GetxController {
  List sipManagementOptions = [
    "SIP Management",
    "SIP Reports",
    "SIP Completion& Renewal"
  ];

  RxBool isSipDataLoading = false.obs;

  RxInt selectedIndex = 0.obs;

  List<GetSipDataNoidel>? sipData;
  List<SipDetailsModel>? sipDetails = [];



  int activeSip = 0;
  int completedSip = 0;
  double totalGold = 0;

  List<Map<String, dynamic>> sipReportData () {
    return [
      {
        "title": "Total SIPs",
        "total": sipData!.length.toString(),
      },
      {
        "title": "Active SIPs",
        "total": activeSip.toString(),
      },
      {
        "title": "Completed SIPs",
        "total": completedSip.toString(),
      },
      {
        "title": "Missed Payments",
        "total": "10",
      },
      {
        "title": "Total Gold Accumulated",
        "total": totalGold.toStringAsFixed(2),
      },
    ];
  }

  final box = GetStorage();

  Future getSipData() async {
    String token = box.read("token");
isSipDataLoading.value = true;
    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.getSipData,
      requestType: RequestType.GET,
      headers: {"Authorization": "Bearer $token"},
    );


    if (response!.statusCode == 200) {

      sipData = getSipDataNoidelFromJson(response.body);

      sipData!.forEach(
        (element) {
          totalGold += element.totalGramsAccumulated;

          if (element.status == "active") {
            activeSip++;
          } else if (element.status == "completed") {
            completedSip++;
          }
        },
      );

      isSipDataLoading.value =false;


    }
  }

  @override
  void onInit() {
    // getSipData();
    super.onInit();
  }
}
