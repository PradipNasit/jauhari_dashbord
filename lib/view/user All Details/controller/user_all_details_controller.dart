import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/controller/user_management_controller.dart';

class UserAllDetailsController extends GetxController {
  RxBool isGoldWithdrawPopUpShow = false.obs;
  RxBool isOTPPopUpShow = false.obs;

  final userDetailsController = Get.put(UserManagementController());

  List<Map<String, String>> userDetailsValue() {
    return [
      {
        "title": "User Name",
        "totalValue": userDetailsController.sipData?.user?.fullName ?? "No Name"
      },
      {
        "title": "User ID",
        "totalValue":  ""
      },
      {
        "title": "Mobile",
        "totalValue":
            userDetailsController.sipData?.user?.mobileNumber.toString() ?? ""
      },
      {
        "title": "Adhar card no.",
        "totalValue":
            userDetailsController.sipData?.user?.aadharCard.toString() ?? ""
      },
      {
        "title": "Total Amount Invested Across All GSPs Till Last Payment Date",
        "totalValue": userDetailsController.sipData?.user?.totalInvestment
                ?.toStringAsFixed(2) ??
            ""
      },
      {
        "title": "Total Gold Bought Across all GSPs Till Last Payment Date",
        "totalValue": userDetailsController.sipData?.user?.totalGramsAccumulated
                ?.toStringAsFixed(2) ??
            ""
      },
      {"title": "Date of Registration", "totalValue": "1/1/2024"},
      {
        "title": "Pan card no.",
        "totalValue":
            userDetailsController.sipData?.user?.panCard.toString() ?? ""
      },
    ];
  }

  List<Map<String, dynamic>> options = [
    {"title": "Gold Withdrawal History", "totalValue": "UserName"},
    {"title": "User History", "totalValue": "user12458"},
    {"title": "Withdraw Gold", "totalValue": "9536 254 235"},
  ];


  final box = GetStorage();
  RxBool isWithDrawLoading = false.obs;

  Future<void> goldWithDraw() async {
    isWithDrawLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.withDrawSip,
      requestType: RequestType.POST,
      body: {"sipId": userDetailsController.sipData?.user?.sipId ?? ""},
      headers: {"Authorization": "Bearer $token"},
    );

    isWithDrawLoading.value = false;

    if (response != null && response.statusCode == 200) {
      // Fluttertoast.showToast(
      //   msg: jsonDecode(response.body)["message"].toString(),
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.SNACKBAR,
      //   fontSize: 14.0,
      // );
      // privacyPolicyController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }
}
