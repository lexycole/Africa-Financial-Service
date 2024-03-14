import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class RefreshTokenController extends ChangeNotifier {
  final LoginController loginController = Get.find<LoginController>();

  Future<void> refreshToken() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': '',
        'Api-Sec-Key':
            '',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      var url = Uri.parse(ApiEndPoints.authEndpoints.refreshToken);
      String refresh = await loginController.getRefreshToken();
      print('refresh: $refresh');

      String body = jsonEncode({
        'refresh': refresh,
      });

      var response = await http.post(url, body: body, headers: headers);
      print('response: $response');
      if (response.statusCode == 200) {
        print('response status code is true');

        final dynamic json = jsonDecode(response.body);
        print('json: $json');
        if (json['success'] == true) {
          var data = json['data'] as Map<String, dynamic>?;
          print('data: $data');
          var newAccessToken = data?['access'] as String?;
          print('newAccessToken: $newAccessToken');

          if (newAccessToken != null) {
            loginController.accessToken.value = newAccessToken;
          } else {
            throw 'Error: New access token is null or empty';
          }
        } else if (json['error']['code'] == 400) {
          throw jsonDecode(response.body)['data']['phone'];
        }
      } else {
        var responseData =
            jsonDecode(response.body)['data'] as Map<String, dynamic>?;

        if (responseData != null) {
          var refreshError = responseData["refresh"] as String?;
          throw refreshError ?? 'Error: Refresh key not found in response';
        } else {
          throw 'Error: Response data is null or empty';
        }
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
      throw 'Error: $e';
    }
  }
}