import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../Model/data.dart';

// ignore: constant_identifier_names
enum ApiType { POST, GET, PATCH, DELETE }

Future apiCall(
    {required String endPoint,
    required Map<String, String> body,
    Map<String, String> header = const {'Content-Type': 'application/json'},
    required ApiType apiType,
    bool isMultiRequest = false,
    String imagePath = '',
    String imageKey = 'profilePhoto',
    required Function(dynamic, bool, int) onSuccess}) async {

  final String baseUrl = 'https://theplayer.webvedanttechnology.com/api/';


  debugPrint("  body   => $body");
  debugPrint("  url   => $endPoint");
  if (apiType == ApiType.GET) {
    // String? token = prefs.getString(StringHelper.token);
    var request = http.Request('GET', Uri.parse(baseUrl+endPoint));
    request.headers.addAll(header);
    request.body = json.encode(body);

    var response = await request.send();
    debugPrint("statusCode  =>  ${response.statusCode}");

    String respStr = await response.stream.bytesToString();
    debugPrint('respStr: $respStr');

    var jsonResponse = json.decode(respStr);
    DataClass dataClass = DataClass.fromJson(jsonResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(dataClass, true, response.statusCode);
    } else {
      onSuccess(dataClass, false, response.statusCode);
    }
  }
  else if (apiType == ApiType.DELETE) {
    // String? token = prefs.getString(StringHelper.token);
    var request = http.Request('DELETE', Uri.parse(baseUrl+endPoint));
    request.headers.addAll(header);

    var response = await request.send();
    debugPrint("statusCode  =>  ${response.statusCode}");

    String respStr = await response.stream.bytesToString();
    debugPrint('respStr: $respStr');

    var jsonResponse = json.decode(respStr);
    DataClass dataClass = DataClass.fromJson(jsonResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(dataClass, true, response.statusCode);
    } else {
      onSuccess(dataClass, false, response.statusCode);
    }
  }
  else if (apiType == ApiType.POST) {
    var response;

    if (isMultiRequest) {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(baseUrl+endPoint))..fields.addAll(body);

      if (imagePath.isNotEmpty) {
        debugPrint('imagePath: $imagePath');
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(imageKey, imagePath, contentType: MediaType("image", "png"));

        request.files.add(multipartFile);
      }
      request.headers.addAll(header);
      response = await request.send();

      debugPrint("statusCode  =>  ${response.statusCode}");
    }
    else {
      var request = http.Request('POST', Uri.parse(baseUrl+endPoint));
      request.body = json.encode(body);
      request.headers.addAll(header);

      response = await request.send();
      debugPrint("statusCode  =>  ${response.statusCode}");
    }

    String respStr = await response.stream.bytesToString();
    debugPrint('respStr: $respStr');

    var jsonResponse = json.decode(respStr);

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      onSuccess(jsonResponse, true, response.statusCode);
    } else {
      onSuccess(jsonResponse, false, response.statusCode);
    }
  } else if (apiType == ApiType.PATCH) {
    debugPrint("Upload body => $body");
    // debugPrint("  token   => " + token);

    var response;

    if (isMultiRequest) {
      http.MultipartRequest request = http.MultipartRequest('PATCH', Uri.parse(baseUrl+endPoint))..fields.addAll(body);

      if (imagePath.isNotEmpty) {
        debugPrint('imagePath: $imagePath');
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(imageKey, imagePath, contentType: MediaType("image", "png"));

        request.files.add(multipartFile);
      }
      request.headers.addAll(header);
      response = await request.send();

      debugPrint("statusCode  =>  ${response.statusCode}");
    } else {
      var request = http.Request('PATCH', Uri.parse(baseUrl+endPoint));
      request.body = json.encode(body);
      request.headers.addAll(header);

      response = await request.send();
      debugPrint("statusCode  =>  ${response.statusCode}");
    }

    String respStr = await response.stream.bytesToString();
    debugPrint('respStr: $respStr');

    var jsonResponse = json.decode(respStr);
    DataClass dataClass = DataClass.fromJson(jsonResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      onSuccess(dataClass, true, response.statusCode);
    } else {
      onSuccess(dataClass, false, response.statusCode);
    }
  }
}
