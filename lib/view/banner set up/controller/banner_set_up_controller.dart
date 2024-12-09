import 'dart:io';import 'dart:html';
import 'dart:typed_data';
import 'package:get/get.dart';

class BannerSetUpController extends GetxController {
  RxList<Map<String, dynamic>> banners = <Map<String, dynamic>>[].obs;

  // Selected banner type
  RxString selectedBannerType = ''.obs;

  // Selected file
  Rx<Uint8List?> selectedFile = Rx<Uint8List?>(null);

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
        update();
      });
    });
    update();
  }
}
