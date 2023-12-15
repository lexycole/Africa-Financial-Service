import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/users_controller.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/models/users_modal.dart';
import 'dart:convert';

import 'package:xcrowme/utils/api_endpoints.dart';

class BalanceController extends GetxController {
  final LoginController loginController = Get.find<LoginController>();
  final UserController userController =
      Get.put(UserController()); // Add this line

  Future<void> fetchAvailableFunds() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.balance); // Replace with your API endpoint

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        var balance = double.parse(jsonData['balance'].toString());

         // Update the balance in the LoginController
        loginController.balance.value = balance;

        // Call setUser to store the user data for balance
        var userData = UserModel(firstName: '', phoneNumber: '');
        Get.find<UserController>().setUser(userData);
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
