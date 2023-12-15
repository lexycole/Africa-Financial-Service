import 'dart:convert';

import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/users_controller.dart';
import 'package:xcrowme/models/users_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/withdraw_screen/index.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final userController = Get.find<UserController>();
  final UserController userController =
      Get.put(UserController()); // Add this line

  RxString accessToken = ''.obs;
  RxDouble balance = 0.0.obs;

  Future<void> loginWithEmail() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'phone': '+234${phoneController.text}',
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          var token = json['data']['tokens']['access'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          // final SharedPreferences prefs = (await _prefs) ?? SharedPreferences.getInstance();
          // final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('tokens', token);
          accessToken.value = token; // Set the access token value

          // Retrieve the first name from the response and set it in the UserController
          var firstName = json['data']['user']['first_name'];
          userController.setUser(UserModel(
              firstName: firstName, phoneNumber: phoneController.text));

          phoneController.clear();
          passwordController.clear();
          showSuccessSnackBar("Welcome Back!", title: "Login Successful");
          Get.off(BottomTab());
        } else if (json['error']['code'] == 400) {
          throw jsonDecode(response.body)['data']['message'] ??
              jsonDecode(response.body)['data']['password'];
        }
      } else {
        throw jsonDecode(response.body)['data']['message'] ??
            jsonDecode(response.body)['data']['password'];
      }
    } catch (error) {
      Get.back();
      showFailureSnackBar('Error', title: error.toString());
      ;
    }
  }
}
