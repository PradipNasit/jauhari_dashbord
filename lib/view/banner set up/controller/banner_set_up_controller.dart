
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:jauhari_dashbord/common/common_api_service.dart';
import 'package:jauhari_dashbord/view/banner%20set%20up/model/banner_model.dart';
import 'package:jauhari_dashbord/view/banner%20set%20up/model/get_all_banners_model.dart';
import 'package:universal_html/html.dart';

class BannerSetUpController extends GetxController {
  RxList<Map<String, dynamic>> banners = <Map<String, dynamic>>[].obs;
  List<GetAllBanners>? bannerData;
  RxList<BannerModel> bannerShortData =<BannerModel> [].obs;

  // Selected banner type
  RxString selectedBannerType = ''.obs;

  // Selected file
  Rx<Uint8List?> selectedFile = Rx<Uint8List?>(null);
  RxString fileName = "".obs;

  // Add a banner
  void addBanner(String type, Uint8List? fileBytes) {
    if (fileBytes != null) {
      banners.add({
        "slNo": banners.length + 1,
        "image": fileBytes,
        "type": type,
        "published": false,
      });
      resetForm();
    } else {
      Get.snackbar("Error", "Please upload an image");
    }
  }

  // Toggle publish status
  void togglePublishStatus(int index) {
    updateBannerStatus(status: bannerShortData[index].status ? "inactive": "active" ,id: bannerShortData[index].id  );
    bannerShortData[index].status = !bannerShortData[index].status;
    bannerShortData.refresh();
  }

  // Delete banner
  void deleteBanner(int index) {
    deleteBannerApi(id: bannerShortData[index].id ?? "");
    bannerShortData.removeAt(index);
    // Update serial numbers
    for (int i = 0; i < banners.length; i++) {
      bannerShortData[i].slNo = i + 1;
    }
    bannerShortData.refresh();
  }

  // Reset form
  void resetForm() {
    selectedBannerType.value = '';
    selectedFile.value = null;
  }

  void pickFile() {
    final uploadInput = FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Only allow images
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();

      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        if (reader.result != null) {
          selectedFile.value = reader.result as Uint8List;
          fileName.value = file.name;

          // Upload the file
        }
      });
    });
  }

  final box = GetStorage();

  Future<void> uploadFile(Uint8List fileBytes, String fileName) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${box.read("token")}',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.baseUrl}/upload/banners'),
      );

      // Add form fields
      request.fields['bannerType'] = "main";

      // Add the file as bytes
      request.files.add(
        http.MultipartFile.fromBytes(
          'files',
          fileBytes,
          filename: fileName,
        ),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(await response.statusCode);

      if (response.statusCode == 201) {
        getBannerData();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  @override
  void onInit() {
    getBannerData();
    // TODO: implement onInit
    super.onInit();
  }

  RxBool isBannerLoading = false.obs;

  Future<void> getBannerData() async {
    final token = box.read("token");
    isBannerLoading.value = true;
    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.getAllBanners,
        requestType: RequestType.GET,
        headers: {"Authorization": "Bearer $token"});

    if (response?.statusCode == 200) {
      bannerShortData.clear();
      bannerData = getAllBannersFromJson(response!.body);
      for (int i = 0; i < bannerData!.length; i++) {
        bannerShortData.add(
          BannerModel(
              id: bannerData![i].id.toString(),
              status: bannerData![i].status.toString() == "Status.ACTIVE"
                  ? true
                  : false,
              slNo: bannerShortData.length +1,
              bannerType: bannerData![i].bannerType.toString(),
              bannerUrl: bannerData![i].image[0].url.toString()),

        );
      }
      isBannerLoading.value = false;
    }
  }

  Future<void> updateBannerStatus({String? id , String? status}) async {
    final token = box.read("token");
    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.updateBannerStatus,
        requestType: RequestType.PATCH,
        headers: {"Authorization": "Bearer $token"},body: {
          "id" : id,
      "status" : status
    });

    if (response?.statusCode == 200) {
    }
  }


  Future<void> deleteBannerApi({String? id}) async {
    final token = box.read("token");
    final response = await CommonApiService.request(
        url: Api.baseUrl + Api.deleteBanner,
        requestType: RequestType.DELETE,
        headers: {"Authorization": "Bearer $token"},body: {
          "id" : id,
    });

    if (response?.statusCode == 200) {
    }
  }

}
