import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/sellers_modal.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'dart:convert';
import 'package:get/get.dart';

class SellerController extends ChangeNotifier {
  final LoginController loginController = Get.find<LoginController>();
  List<SellerModel> sellers = []; 
  Future<void> createSeller(SellerModel seller) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': '',
        'Api-Sec-Key':
            '',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createSeller);
      Map body = {
        'first_name': seller.firstName,
        'last_name': seller.lastName,
        'phone': seller.phone,
        'dob': seller.dob,
      };
      var response = await http.post(url, body: body, headers: headers);
      
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print(json);
        showSuccessSnackBar("Seller created successfully", title: "Perfect");
      } else {
        throw jsonDecode(response.body)['data']["first_name"] ??
            jsonDecode(response.body)['data']['last_name'] ??
            jsonDecode(response.body)['data']['phone'] ??
            jsonDecode(response.body)['data']['dob '];
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
      throw 'Error: $e';
    }
  }
}
