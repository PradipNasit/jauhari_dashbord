import 'dart:developer';

import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jauhari_dashbord/apis/univarsal_apis.dart';
import 'package:universal_html/html.dart';

class BannerSetUpController extends GetxController {
  RxList<Map<String, dynamic>> banners = <Map<String, dynamic>>[].obs;

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
    banners[index]["published"] = !banners[index]["published"];
    banners.refresh();
  }

  // Delete banner
  void deleteBanner(int index) {
    banners.removeAt(index);
    // Update serial numbers
    for (int i = 0; i < banners.length; i++) {
      banners[i]["slNo"] = i + 1;
    }
    banners.refresh();
  }

  // Reset form
  void resetForm() {
    selectedBannerType.value = '';
    selectedFile.value = null;
  }

  // Pick a file
  // void pickFile() {
  //   final uploadInput = FileUploadInputElement();
  //   uploadInput.accept = 'image/*'; // Only allow images
  //   uploadInput.click();
  //   uploadInput.onChange.listen((event) {
  //     final file = uploadInput.files!.first;
  //     final reader = FileReader();
  //     reader.readAsArrayBuffer(file);
  //     reader.onLoadEnd.listen((event) {
  //       selectedFile.value = reader.result as Uint8List;
  //       fileName.value = file.name;
  //       log(name: "Selected File", file.name);
  //
  //       update();
  //     });
  //   });
  //
  //   update();
  // }
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
          uploadFile(selectedFile.value!, file.name);
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

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }



}
