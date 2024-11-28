import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/social%20media/model/request/create_social_media_request_model.dart';

class SocialMediaController extends GetxController {

  final platFormController = TextEditingController();
  final platLinkController = TextEditingController();


  RxBool isFaqPopUpShow = false.obs;



  final quill.QuillController tAndCController = quill.QuillController.basic();
  final quill.QuillController privacyPolicyController = quill.QuillController.basic();
  final quill.QuillController cancellationPolicyController = quill.QuillController.basic();
  final quill.QuillController refundAndReturnController = quill.QuillController.basic();
  final quill.QuillController aboutUsController = quill.QuillController.basic();
  final quill.QuillController faqController = quill.QuillController.basic();
  final quill.QuillController socialMediaLinkController = quill.QuillController.basic();

  RxList<Map<String, dynamic>> faqList = <Map<String, dynamic>>[
    {"slNo": 1, "question": "What is Flutter?", "answer": "A UI toolkit.", "ranking": 1, "status": "Active"},
    {"slNo": 2, "question": "What is Dart?", "answer": "Programming language.", "ranking": 2, "status": "Active"},
    {"slNo": 3, "question": "How to use GetXdskjnkjdsnfkjnkjfnkjfkjfnksnfkjnfkdsnfkksdnfnsdfndsnfknsdjkfnsdkjfd?", "answer": "State management.", "ranking": 3, "status": "Inactive"},
  ].obs;

  RxList<Map<String, dynamic>> filteredList = <Map<String, dynamic>>[].obs;

  SocialMediaController() {
    filteredList.assignAll(faqList);
  }

  // Search FAQ
  void searchFAQ(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(faqList);
    } else {
      filteredList.assignAll(
        faqList.where((faq) => faq["question"].toString().toLowerCase().contains(query.toLowerCase())),
      );
    }
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

  CreateSocialMediaRequestModel createSocialMediaRequestModel () {
    return CreateSocialMediaRequestModel(platform: platFormController.text, link: platLinkController.text);


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

}