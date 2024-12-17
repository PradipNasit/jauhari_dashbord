import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/social%20media/model/request/create_social_media_request_model.dart';
import 'package:jauhari_dashbord/view/social%20media/model/response/edit_faq_model.dart';
import 'package:jauhari_dashbord/view/social%20media/model/response/get_faq_model.dart';

class SocialMediaController extends GetxController {
  final platFormController = TextEditingController();
  final platLinkController = TextEditingController();

  RxBool isFaqPopUpShow = false.obs;

  var filteredListForEdit = <GetFaqModel>[].obs; // Your data model
  var  editableIndex = (-1).obs; // Index of the container being edited
  var questionControllers = <TextEditingController>[].obs;
  var answerControllers = <TextEditingController>[].obs;

  final addNewQuestionController = TextEditingController();
  final addNewAnswerController = TextEditingController();

  final quill.QuillController tAndCController = quill.QuillController.basic();
  final quill.QuillController privacyPolicyController =
      quill.QuillController.basic();
  final quill.QuillController cancellationPolicyController =
      quill.QuillController.basic();
  final quill.QuillController refundAndReturnController =
      quill.QuillController.basic();
  final quill.QuillController aboutUsController = quill.QuillController.basic();
  final quill.QuillController faqController = quill.QuillController.basic();
  final quill.QuillController socialMediaLinkController =
      quill.QuillController.basic();

  @override
  void onInit() {
    super.onInit();
    // Initialize data and controllers
  }

  void enterEditMode(int index) {
    editableIndex.value = index; // Set the editable index
  }

  void saveChanges(int index) {
    filteredList[index].question = questionControllers[index].text;
    filteredList[index].answer = answerControllers[index].text;
    editableIndex.value = -1;
    editFaq(filteredList[index].id, filteredList[index].question,
        filteredList[index].answer);
  }

  void deleteItem(int index) {
    filteredListForEdit.removeAt(index);
    questionControllers.removeAt(index);
    answerControllers.removeAt(index);
  }

  RxList<GetFaqModel> filteredList = <GetFaqModel>[].obs;

  // Search FAQ
  void searchFAQ(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(data);
    } else {
      filteredList.assignAll(
        data.where((faq) => faq.question
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())),
      );
    }
    log(
        name: "Faq Lent",
        filteredList.value
            .map(
              (e) => e.answer,
            )
            .toString());
  }



  RxBool isSignInLoading = false.obs;
  RxBool isCancellationPolicyLoading = false.obs;
  RxBool isTermAndConditionLoading = false.obs;
  RxBool isPrivacyPolicyLoading = false.obs;
  RxBool isReturnAndRefundLoading = false.obs;
  RxBool isFaqLoading = false.obs;
  RxBool isGetFaq = false.obs;

  List<GetFaqModel> data = [];

  CreateSocialMediaRequestModel createSocialMediaRequestModel() {
    return CreateSocialMediaRequestModel(
        platform: platFormController.text, link: platLinkController.text);
  }

  final box = GetStorage();

  void clearRequestModel() {
    platFormController.clear();
    platLinkController.clear();
  }

  Future<void> createSocialMedia() async {
    isSignInLoading.value = true;
    String token = box.read("token");

    final requestData = createSocialMediaRequestModel();

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.createBusiness,
      requestType: RequestType.POST,
      body: requestData.toJson(),
      headers: {"Authorization": "Bearer $token"},
    );

    isSignInLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      clearRequestModel();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> createCancellationPolicy() async {
    isCancellationPolicyLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.createCancellationPolicy,
      requestType: RequestType.POST,
      body: {"content": cancellationPolicyController.toString()},
      headers: {"Authorization": "Bearer $token"},
    );

    isCancellationPolicyLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      cancellationPolicyController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> createTermAndCondition() async {
    isTermAndConditionLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.createTermsAndCondition,
      requestType: RequestType.POST,
      body: {"content": tAndCController.toString()},
      headers: {"Authorization": "Bearer $token"},
    );

    isTermAndConditionLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      tAndCController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> createPrivacyPolicy() async {
    isPrivacyPolicyLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.privacyPolicy,
      requestType: RequestType.POST,
      body: {"content": privacyPolicyController.toString()},
      headers: {"Authorization": "Bearer $token"},
    );

    isPrivacyPolicyLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      privacyPolicyController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> createReturnAndRefund() async {
    isReturnAndRefundLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.returnAndRefund,
      requestType: RequestType.POST,
      body: {"content": refundAndReturnController.getPlainText()},
      headers: {"Authorization": "Bearer $token"},
    );

    isReturnAndRefundLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      refundAndReturnController.clear();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> createFaq() async {
    isFaqLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.createFaq,
      requestType: RequestType.POST,
      body: {
        "question": addNewQuestionController.text.toString(),
        "answer": addNewAnswerController.text.toString()
      },
      headers: {"Authorization": "Bearer $token"},
    );

    isFaqLoading.value = false;

    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );
      addNewQuestionController.clear();
      addNewAnswerController.clear();
      getFaq();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> editFaq(
      String id, String updatedQuestion, String updatedAnswer) async {
    isFaqLoading.value = true;
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.editFaq,
      requestType: RequestType.PATCH,
      body: {"id": id, "question": updatedQuestion, "answer": updatedAnswer},
      headers: {"Authorization": "Bearer $token"},
    );

    isFaqLoading.value = false;
    getFaq();
    if (response != null && response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        fontSize: 14.0,
      );

      getFaq();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> getFaq() async {
    isGetFaq.value = true;
    filteredList.clear();
    questionControllers.clear();
    answerControllers.clear();
    filteredListForEdit.clear();
    String token = box.read("token");

    final response = await CommonApiService.request(
      url: Api.baseUrl + Api.getFaq,
      requestType: RequestType.GET,
      headers: {"Authorization": "Bearer $token"},
    );

    isGetFaq.value = false;

    if (response != null && response.statusCode == 200) {
      data = getFaqModelFromJson(response.body);
      filteredList.assignAll(data);
      filteredListForEdit.assignAll(data);
      for (var item in filteredListForEdit) {
        questionControllers.add(TextEditingController(text: item.question));
        answerControllers.add(TextEditingController(text: item.answer));
      }
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  @override
  void onReady() {
    getFaq();
    // TODO: implement onReady
    super.onReady();
  }
}
