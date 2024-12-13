import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiMethods {
  Future<dynamic> getApi(String apiName) async {
    try {
      final res = await http.get(Uri.parse(apiName));
      return res;
    } catch (e, sT) {
      debugPrint("Error , $e and stackTrace :: $sT");
      throw Exception();
    }
  }

  Future<bool> postApi(
      {required Map<String, dynamic> body, required String apiName}) async {
    try {
      print("api :: ${apiName}");
      print("body :; ${body}");
      final res = await http.post(
        headers: {
          'Content-Type': 'application/json',
        },
        Uri.parse(apiName),
        body: jsonEncode(body),
      );
      print("respones :: ${res.body}");
      print("Status Code :: ${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
      // return false;
    } catch (e, sT) {
      debugPrint("Error , $e and stackTrace :: $sT");
      return false;
      // throw Exception();
    }
  }

  Future<Map<String, dynamic>> putApi(
      {required Map<String, dynamic> body, required String apiName}) async {
    try {
      print("api :: ${apiName}");
      print("body :; ${body}");

      final res = await http.put(
        headers: {
          'Content-Type': 'application/json',
        },
        Uri.parse(apiName),
        body: jsonEncode(body),
      );
      print("respones :: ${res.body}");
      print("Status Code :: ${res.statusCode}");
      if (res.statusCode == 200) {
        return {
          "response": res.body,
          "is_valid": true,
        };
      } else {
        return {
          "response": "",
          "is_valid": false,
        };
      }
      // print("respones :: $res");
    } catch (e, sT) {
      debugPrint("Error , $e and stackTrace :: $sT");
      return {
        "response": "",
        "is_valid": true,
      };
      // throw Exception();
    }
  }

  Future<bool> saveFilesAndKeys({
    required File file1,
    required File file2,
    required String userId,
    required String aadhaarNumber,
    required String name,
    required String emailId,
    required String phoneNumber,
    required String apiUrl,
  }) async {
    try {
      print("Api :: ${apiUrl}");
      print("Api :: ${userId}");
      print("Api :: ${aadhaarNumber}");
      print("Api :: ${name}");
      print("Api :: ${emailId}");
      print("Api :: ${phoneNumber}");
      // Create a multipart request
      var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      print("File1 Path: ${file1.path}, Size: ${file1.lengthSync()}");
      print("File2 Path: ${file2.path}, Size: ${file2.lengthSync()}");
      // Attach files
      request.files.add(
        http.MultipartFile(
          'profile_image',
          file1.readAsBytes().asStream(),
          file1.lengthSync(),
        ),
      );
      request.files.add(
        http.MultipartFile(
          'aadhaar_image',
          file2.readAsBytes().asStream(),
          file2.lengthSync(),
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll({
        "user_id": userId,
        "name": name,
        "email": emailId,
        "aadhaar_number": aadhaarNumber,
        "phone": phoneNumber,
      });
      print("request: " + request.toString());
      // Send the request
      var response = await request.send();
      print("ressspone :: ${response.request}");
      // Debug: Print request details
      print("Request Fields: ${request.fields}");
      print("Request Files: ${request.files.map((file) => file.field)}");

      // Handle the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = jsonDecode(responseBody);
        print('Success: $decodedResponse');
        return true;
      } else {
        // print("Reponse  :: ${response.}")
        print('Failed to save data. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }
}

final apiMethods = ApiMethods();
