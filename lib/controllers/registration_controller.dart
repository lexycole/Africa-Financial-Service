import 'dart:convert';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/users_controller.dart';
import 'package:xcrowme/models/users_modal.dart';
import 'package:xcrowme/screens/verify-otp_screen/index.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RegistrationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RxString accessToken = ''.obs;
  RxDouble balance = 0.0.obs;
  
  Future<void> registerWithEmail() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': 'gi6paFHGatKXClIE',
        'Api-Sec-Key':'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      };
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        'first_name': firstnameController.text,
        'last_name': lastnameController.text,
        'email': emailController.text,
        'dob': dobController.text,
        "phone":  '+234${phoneController.text}',
        'password': passwordController.text,
        'password2': password2Controller.text,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          showSuccessSnackBar("All went well", title: "Perfect");
          var otp = json['data']['otp'];
          
          var userData = UserModel(
              firstName: firstnameController.text,
              phoneNumber: phoneController.text
          );
          Get.find<UserController>().setUser(userData);          
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('otp', otp);
          firstnameController.clear();
          lastnameController.clear();
          dobController.clear();
          emailController.clear();
          passwordController.clear();
          password2Controller.clear();
          phoneController.clear();
        
          Get.to(VerifyOTPScreen(phoneNumber: userData.phoneNumber));        
        } else {
          throw jsonDecode(response.body)['data']["password"] ??
              jsonDecode(response.body)['data']['email'] ??
              jsonDecode(response.body)['data']['phone'];
        }
      } else {
        throw jsonDecode(response.body)['data']["password"] ??
            jsonDecode(response.body)['data']['email'] ??
            jsonDecode(response.body)['data']['phone'];
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
      ;
    }
  }
}
