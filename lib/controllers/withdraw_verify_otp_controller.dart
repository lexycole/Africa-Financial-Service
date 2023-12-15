import 'dart:convert';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/sign_in_screen/index.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/users_controller.dart';


class WithdrawVerifyOtpController extends GetxController {
  final LoginController loginController = Get.find<LoginController>();

  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> verifyotp() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.verifyToken);
          var userData = Get.find<UserController>().user;
          String phoneNumber = userData!.phoneNumber;

      Map body = {
        'otp': otpController.text,
        'phone':'+234$phoneNumber',
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          otpController.clear();
          Get.to(()=> SignInScreen());
        } else if (json['error']['code'] == 400) {
          throw jsonDecode(response.body)['data']['otp'];
        } 
      } else {
        throw jsonDecode(response.body)['data']['otp'];
      }
    } catch (error) {
      Get.back();
      showFailureSnackBar('Error', title: error.toString());
    }
  }
}
