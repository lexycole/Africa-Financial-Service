import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'dart:convert';

import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/utils/api_endpoints.dart';

class BankController extends GetxController {
  final LoginController loginController =
      Get.find(); // Get the instance of LoginController

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
          // Update the bankList with the retrieved banks
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


// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BankController extends GetxController {
//   final String baseUrl = 'https://api.example.com'; // Replace with your API base URL
//   final String accessToken; // Access token

//   BankController({required this.accessToken});

//   Future<List<Map<String, dynamic>>> fetchBankList(String otp, String phone) async {
//     try {
//       var url = Uri.parse('$baseUrl/banks');
//       var headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       };
//       var body = jsonEncode({
//         'otp': otp,
//         'phone': phone,
//       });

//       var response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         var responseData = response.body;
//         var jsonData = jsonDecode(responseData);
        
//         // Extract the list of banks from the response
//         var banks = List<Map<String, dynamic>>.from(jsonData);
//         print(banks);
//         return banks;
//       } else {
//         throw 'Error: ${response.statusCode}';
//       }
//     } catch (e) {
//       throw 'Error: $e';
//     }
//   }
// }
