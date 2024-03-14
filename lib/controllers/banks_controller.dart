import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'dart:convert';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/utils/api_endpoints.dart';


class BankController extends GetxController {
  final LoginController loginController = Get.find();

  RxList<Map<String, dynamic>> bankList = RxList<Map<String, dynamic>>([]);
  RxString selectedBank = ''.obs;

  Future<void> fetchBankList(String otp, String phone) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.banks);

      var response = await http.get(url, headers: headers);
      print(response);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        if (json['success'] == true) {
          bankList.assignAll(List<Map<String, dynamic>>.from(json));
          print(bankList);
        } else if (json['error']['code'] == 400) {
          throw jsonDecode(response.body)['data']['key'];
        }
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
      throw 'Error: $e';
    }
  }
}
