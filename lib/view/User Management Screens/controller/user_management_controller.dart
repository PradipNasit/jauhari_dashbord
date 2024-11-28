import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/request/delete_user_request.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/request/edit_sip_request.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/request/edit_user_request.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/get_user_data_model.dart';
import 'package:jauhari_dashbord/view/User%20Management%20Screens/model/response/user_details_model.dart';

class UserManagementController extends GetxController {
  final box = GetStorage();

  final userSearchController = TextEditingController();

  final fullNameCtr = TextEditingController();
  final aadharCardCtr = TextEditingController();
  final panCardCtr = TextEditingController();
  final emailctr = TextEditingController();
  final nomineeNameCtr = TextEditingController();
  final mobileNumberCtr = TextEditingController();


  var editingRowIndex = (-1).obs;

  List<GetUserDataModel>? userData;

  List<UserDetails> useDetails = [];
  List<UserDetails> tempValue = [];

  RxBool userDataLoading = false.obs;


  void filterUser(String query) {
    if (query.isEmpty) {
      userDataLoading.value = true;
      useDetails = tempValue;
      userDataLoading.value = false;
      update();
    } else {
      userDataLoading.value = true;
      List<UserDetails> tempUserData = useDetails!.where((product) {
        return product.fullName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      useDetails = tempUserData;
      userDataLoading.value = false;
      update();
    }
  }

  EditUserRequest editReqData(String id) {
    return EditUserRequest(
        fullName: fullNameCtr.text,
        mobileNumber: mobileNumberCtr.text,
        nomineeName: nomineeNameCtr.text,
        email: emailctr.text,
        aadharCard: aadharCardCtr.text,
        id: id,
        panCard: panCardCtr.text,
        nomineeNunmber: "9714961893");
  }

  EditSipRequest editSipReq( String id , String status) {
    return EditSipRequest(id: id, status: status);
  }


  DeleteUserRequest deleteUserReq( String id) {

    return DeleteUserRequest(id: id);
  }

  Future<void> getUserData() async {
    final token = box.read("token");
    userDataLoading.value = true;
    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.getUserData,
      requestType: RequestType.GET,
      headers: {"Authorization": "Bearer $token"},
    );
    userDataLoading.value = false;
    if (response?.statusCode == 200) {
      useDetails.clear();
      tempValue.clear();

      userData = getUserDataNoidelFromJson(response!.body);
      log(name: "userData", userData.toString());

      for (var i = 0; i < userData!.length; i++) {
        useDetails.add(UserDetails(
            id: userData![i].id,
            createdAt: userData![i].createdAt,
            nomineeNumber: "",
            updatedAt: userData![i].updatedAt,
            fullName: userData![i].fullName,
            mobileNumber: userData![i].mobileNumber.toString(),
            email: userData![i].email,
            aadharCard: userData![i].aadharCard.toString(),
            panCard: userData![i].panCard,
            nomineeName: userData![i].nomineeName,
            role: userData![i].role,
            sipStatus: userData![i].sipStatus));
      }
      tempValue = useDetails;
    }
  }

  Future<void> editUserData(String id) async {
    final token = box.read("token");
    final reqData = editReqData(id);
    log(name: "editUserReqbopdy", reqData.tojson().toString());

    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.editUserData,
        requestType: RequestType.PATCH,
        headers: {"Authorization": "Bearer $token"},
        body: reqData.tojson());
    log(name: "editUserdata", response!.body.toString());

    if (response?.statusCode == 200) {
      getUserData();
    }
  }


  Future<void> editSipStatusData(String id , String status) async {
    final token = box.read("token");
    final editSipRedData = editSipReq(id , status);

    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.editSipData,
        requestType: RequestType.PATCH,
        headers: {"Authorization": "Bearer $token"},
        body: editSipRedData.toJson());
    log(name: "editSipData", response!.body.toString());

  }


  Future<void> deleteUser(String id) async {
    final token = box.read("token");
     final deleteUserData = deleteUserReq(id );

    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.deleteUserData,
        requestType: RequestType.DELETE,
        headers: {"Authorization": "Bearer $token"},
        body: deleteUserData.toJson());

if(response!.statusCode == 200){

  getUserData();

}

  }


  @override
  void onInit() {
    getUserData();
    // TODO: implement onInit
    super.onInit();
  }
}