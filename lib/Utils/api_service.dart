import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetxService {
  final String baseUrl = 'https://theplayer.webvedanttechnology.com/api/';

  @override
  void onInit(){
    super.onInit();
    debugPrint('APIService called');
  }

  Future<dynamic> postApiCall(
      String endpoint,
      Map<String, String> body,
      Map<String, String>? headers,
      {bool isMultiRequest = false}
      ) async
  {
    try {

      var response;

      if (isMultiRequest) {
        http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint))..fields.addAll(body);
        request.headers.addAll(headers ?? {'Content-Type': 'application/json'});
        response = await request.send();

        debugPrint("statusCode  =>  ${response.statusCode}");
      } else {
        response = await http.post(
          Uri.parse(baseUrl + endpoint),
          headers: headers ?? {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );
      }

      debugPrint('url: ${baseUrl + endpoint}');
      debugPrint('body: ${jsonEncode(body)}');

      if (response.statusCode == 200) {
        debugPrint('response: ${response.body.toString()}');
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }
}