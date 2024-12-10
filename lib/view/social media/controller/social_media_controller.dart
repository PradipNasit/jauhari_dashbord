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
import 'package:jauhari_dashbord/view/social%20media/model/response/get_faq_model.dart';

class SocialMediaController extends GetxController {
  final platFormController = TextEditingController();
  final platLinkController = TextEditingController();

  RxBool isFaqPopUpShow = false.obs;

  final questionController = TextEditingController();
  final answerController = TextEditingController();

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

  RxList<Map<String, dynamic>> faqList = <Map<String, dynamic>>[
    {
      "slNo": 1,
      "question": "What is Flutter?",
      "answer": "A UI toolkit.",
      "ranking": 1,
      "status": "Active"
    },
    {
      "slNo": 2,
      "question": "What is Dart?",
      "answer": "Programming language.",
      "ranking": 2,
      "status": "Active"
    },
    {
      "slNo": 3,
      "question":
          "How to use GetXdskjnkjdsnfkjnkjfnkjfkjfnksnfkjnfkdsnfkksdnfnsdfndsnfknsdjkfnsdkjfd?",
      "answer": "State management.",
      "ranking": 3,
      "status": "Inactive"
    },
  ].obs;

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
    log(name: "Faq Lent" , filteredList.value.map((e) => e.answer,).toString());

  }

  // Delete FAQ
  void deleteFAQ(int index) {
    faqList.removeAt(index);
    searchFAQ(''); // Refresh the filtered list
  }

  // Edit FAQ (For simplicity, replace with updated data)
  void editFAQ(int index, String newQuestion, String newAnswer) {
    faqList[index] = {
      ...faqList[index],
      "question": newQuestion,
      "answer": newAnswer,
    };
    searchFAQ(''); // Refresh the filtered list
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
        "question": questionController.text.toString(),
        "answer": answerController.text.toString()
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
      questionController.clear();
      answerController.clear();
      getFaq();
    } else {
      print('Failed to send data: ${response?.statusCode}');
    }
  }

  Future<void> getFaq() async {
    isGetFaq.value = true;
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
