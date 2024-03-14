import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/products_list_modal.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'dart:convert';
import 'package:get/get.dart';

class ProductsController extends ChangeNotifier {
  final LoginController loginController = Get.find<LoginController>();
  Future<void> createSeller(ProductsListModal products) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': '',
        'Api-Sec-Key':'',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createProduct);
      Map<String, dynamic> body = {
        'label': products.label,
        'price': products.price,
        'description': products.description,
        'quantity': products.quantity,      };
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print(json);
        showSuccessSnackBar("Product created successfully", title: "Perfect");
      } else {
        throw jsonDecode(response.body)['data']["label"] ??
            jsonDecode(response.body)['data']['price'] ??
            jsonDecode(response.body)['data']['description'] ??
            jsonDecode(response.body)['data']['quantity'] ??
            jsonDecode(response.body)['data']['unlimited'];
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
      throw 'Error: $e';
    }
  }
}
