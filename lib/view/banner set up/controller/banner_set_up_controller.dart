import 'dart:developer';
import 'dart:io';import 'dart:html';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
  void pickFile() {
    final uploadInput = FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Only allow images
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        selectedFile.value = reader.result as Uint8List;
        fileName.value = file.name;
        log(name: "Selected File", file.name);

        update();
      });
    });

    update();
  }
  final box = GetStorage();

  Future<void> uploadFile(Uint8List fileBytes, String fileName) async {
    try {
      // Define the URL of your API
      final uri = Uri.parse("http://46.202.163.138:5000/api/upload/banners");

      // Create a multipart request
      final request = http.MultipartRequest('POST', uri);

      // Add text fields
      request.fields['bannerType'] = 'main';

      // Add the file as a multipart file
      request.files.add(
        http.MultipartFile.fromBytes(
          'banners', // Field name in the API
          fileBytes,
          filename: fileName,
        ),
      );

      // Add headers if needed
      request.headers['Authorization'] = 'Bearer ${box.read("token")}';

      // Send the request
      final response = await request.send();

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("File uploaded successfully!");
      } else {
        print("Failed to upload file: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }


}
