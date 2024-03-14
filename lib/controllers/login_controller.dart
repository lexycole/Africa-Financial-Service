import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/users_controller.dart';
import 'package:xcrowme/models/users_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';


class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final UserController userController = Get.put(UserController());
  final GetStorage _getStorage = GetStorage();

  RxString accessToken = ''.obs;
  RxDouble balance = 0.0.obs;  


  DateTime? tokenFetchTime;

  bool isAuthenticated() {
    return accessToken.value.isNotEmpty; 
  }

  String getAccessToken() {
    return accessToken.value;
  }

  Future<String> getRefreshToken() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('refresh_token') ?? '';
    }

  Future<void> storeTokens(String token, String refreshToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('tokens', token);
  await prefs.setString('refresh_token', refreshToken);
}

  Future<void> login() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': '',
      'Api-Sec-Key': '',
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
          print('token: $token');
          var refreshToken = json['data']['tokens']['refresh'];
          print('refreshToken:$refreshToken');
          tokenFetchTime = DateTime.now();
          print('tokenFetchTime: $tokenFetchTime');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          
          await prefs?.setString('tokens', token);
          await prefs?.setString('refresh_token', refreshToken);
          accessToken.value = token;

          var firstName = json['data']['user']['first_name'];
          userController.setUser(UserModel(
              firstName: firstName, phoneNumber: phoneController.text));

          phoneController.clear();
          passwordController.clear();
          showSuccessSnackBar("Welcome Back!", title: "Login Successful");
          Get.off(BottomTab());
        } else if (json['error']['code'] == 400) {
          throw jsonDecode(response.body)['data']['phone'] ??
              jsonDecode(response.body)['data']['password'];
        }
      } else {
        throw jsonDecode(response.body)['data']['phone'] ??
              jsonDecode(response.body)['data']['password'];
      }
    } catch (error) {
      Get.back();
      showFailureSnackBar('Error', title: error.toString());
      ;
    }
  }

  Future<void> refreshToken() async {
    try {
      Future<String> refreshToken = getRefreshToken();
      accessToken.value = 'new_access_token';

    } catch (error) {
      print('Error refreshing token: $error');
    }
  }

  
}