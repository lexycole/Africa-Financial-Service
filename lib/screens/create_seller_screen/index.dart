import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/sellers_modal.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:xcrowme/screens/profile_screen/index.dart';

void main() {
  runApp(CreateSellerScreen());
}

class CreateSellerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateSellerApp(),
    );
  }
}

class CreateSellerApp extends StatefulWidget {
  @override
  _CreateSellerAppState createState() => _CreateSellerAppState();
}

class _CreateSellerAppState extends State<CreateSellerApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  Future<void> _createSeller() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String phone = '+234${_phoneController.text}';
    final String dob = _dobController.text;

    final Map<String, dynamic> body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'dob': dob,
    };

    try {
      final LoginController loginController = Get.find<LoginController>();

      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createSeller);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': 'gi6paFHGatKXClIE',
        'Api-Sec-Key':
            'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      final http.Response response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String sellerId = responseData['data']['uid'];

        final SellerModel seller = SellerModel(
          uid: responseData['data']['uid'],
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          dob: dob,
          sellerId: sellerId,
        );
        Get.to(
            () => ProfileScreen(
                  initialValue: '',
                  sellerId: seller.uid,
                ),
            transition: Transition.rightToLeft);
        // Get.to(ListOfAllSellersScreen(newSellers: [seller])); // Pass the updated sellers list
        // Get.to(ListOfAllSellersScreen(newSellers: [seller])); // Pass the updated sellers list
        showSuccessSnackBar("Seller Created Successfully", title: "Perfect");
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  // SizedBox(width: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Create Seller",
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
                      // Create Seller
                      Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          width: double.maxFinite,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create a new seller',
                                  style: TextStyle(
                                      fontSize: Dimensions.font26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                      SizedBox(height: Dimensions.height20),
                      // Phone Number
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First Name
                                  AppTextField(
                                    hintText: 'First Name',
                                    icon: Icons.account_circle_outlined,
                                    textController: _firstNameController,
                                  ),
                                  SizedBox(height: Dimensions.height20),
                                  // Last Name
                                  AppTextField(
                                    hintText: 'Last Name',
                                    icon: Icons.account_circle_outlined,
                                    textController: _lastNameController,
                                  ),
                                  SizedBox(height: Dimensions.height20),
                                  AppTextField(
                                      hintText: 'yyyy-mm-dd',
                                      icon: Icons.date_range_outlined,
                                      textController: _dobController),
                                  SizedBox(height: Dimensions.height20),
                                  // Phone Number
                                  AppTextField(
                                    hintText: '+234**********',
                                    icon: Icons.phone,
                                    textController: _phoneController,
                                  ),
                                  SizedBox(height: Dimensions.height30),
                                  // Sign In
                                  Center(
                                    child: GestureDetector(
                                      onTap: _createSeller,
                                      child: Container(
                                        width: Dimensions.screenWidth / 10 * 9,
                                        height: Dimensions.screenHeight / 10,
                                        decoration: BoxDecoration(
                                          color: AppColors.AppBannerColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                        ),
                                        child: Center(
                                          child: BigText(
                                            text: "Create Seller",
                                            size: Dimensions.font20 +
                                                Dimensions.font20 / 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.screenHeight * 0.05),
                                ],
                              )))
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
