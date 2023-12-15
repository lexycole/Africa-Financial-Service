import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/controllers/banks_controller.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/screens/home_screen/index.dart';
import 'package:xcrowme/screens/withdraw_screen/withdraw_verify_otp.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final LoginController loginController =
      Get.find();

  List<Map<String, dynamic>> dropdownItems = [];
  Map<String, dynamic>? selectedValue;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.banks);

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        setState(() {
          dropdownItems = List<Map<String, dynamic>>.from(jsonData);
        });
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      // showFailureSnackBar('Error', title: e.toString());
      throw 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    var accountNumberController = TextEditingController();
    var amountController = TextEditingController();
    // final BankController bankController = Get.find<BankController>();
    final BankController bankController = Get.put(BankController());


    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.width20),
              width: Dimensions.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: AppColors.AppBannerColor),
                    onPressed: () => Get.offAll(BottomTab(initialIndex: 1)),
                  ),
                  SizedBox(width: Dimensions.width15),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Withdraw",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          width: double.maxFinite,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Withdraw',
                                  style: TextStyle(
                                      fontSize: Dimensions.font26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                      SizedBox(height: Dimensions.height20),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        width: double.infinity,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 10),
                                  color: Color.fromARGB(255, 162, 158, 158)
                                      .withOpacity(0.2))
                            ]),
                        child: DropdownButton<Map<String, dynamic>>(
                          value: selectedValue,
                          items: dropdownItems.map((item) {
                            String name = item['name'];
                            String code = item['code'];
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: item,
                              child: Text('$name ($code)'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          hint: Text('Select a bank'),
                          isExpanded: true,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        hintText: 'Account Number',
                        icon: Icons.pin_outlined,
                        textController: accountNumberController,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        hintText: 'Amount',
                        icon: Icons.money_outlined,
                        textController: amountController,
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      GestureDetector(
                          // onTap: () => Get.to(() => HomeScreen(newStores: [],))
                          onTap: () => Get.to(() => WithdrawVerifyOTP(phoneNumber: '',)),
                          child: Container(
                              width: Dimensions.screenWidth / 10 * 9,
                              height: Dimensions.screenHeight / 10,
                              decoration: BoxDecoration(
                                color: AppColors.AppBannerColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                  child: BigText(
                                      text: "Withdraw",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white)))),
                      SizedBox(height: Dimensions.screenHeight * 0.05)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
