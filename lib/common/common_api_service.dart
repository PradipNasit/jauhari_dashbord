import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

enum RequestType { GET, POST, PUT, DELETE , PATCH, }

class CommonApiService {
  static Future<http.Response?> request({
    required String url,
    required RequestType requestType,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      // Set default headers if not provided
      final defaultHeaders = {
         'Content-Type': 'application/json',
        ...?headers,
      };

      // Select the request type
      http.Response? response;
      log("header: ${defaultHeaders}");

      switch (requestType) {

        case RequestType.GET:
          response = await http.get(Uri.parse(url), headers: defaultHeaders);
          break;
        case RequestType.POST:
          response = await http.post(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
        case RequestType.PATCH:
            response = await http.patch(
              Uri.parse(url),
              headers: defaultHeaders,
              body: jsonEncode(body),
            );
            break;
        case RequestType.PUT:
          response = await http.put(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
        case RequestType.DELETE:
          response = await http.delete(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
      }

      // Logging the request and response details
      log("API Request: [$requestType] $url");
      if (body != null) log("Request Body: $body");
      log("Response Status Code: ${response?.statusCode}");
      log("Response Body: ${response?.body}");

      // Check if the response status is OK (200 - 299)
      if (response != null && (response.statusCode >= 200 && response.statusCode < 300)) {

        return response;
      } else if (response.statusCode == 401){
        Get.deleteAll(force: true);
        // Get.off(()=> SignInScreen());
      }else {
        // Handle error responses and show toast
        final errorMessage = jsonDecode(response?.body ?? '{}')['error'] ?? 'Something went wrong';
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return response;
      }
    } catch (error) {
      // Handle general errors (like network issues)
      log('API Error: $error');
      Fluttertoast.showToast(
        msg: 'Error: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return null;
    }
  }
}
