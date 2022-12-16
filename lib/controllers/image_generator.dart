import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  var url = Uri.parse("https://api.openai.com/v1/images/generations");
  var api_token = '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';

  final data = "".obs;
  final isLoading = false.obs;

  Future getImage({required String imageText}) async {
    try {
      isLoading.value = true;
      var request = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $api_token',
          },
          body: jsonEncode({
            'prompt': imageText,
            'n': 1,
          }));
      if (request.statusCode == 200) {
        isLoading.value = false;
        data.value = jsonDecode(request.body)['data'][0]['url'];
        debugPrint(data.value);
      } else {
        isLoading.value = false;
        debugPrint(jsonDecode(request.body));
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
