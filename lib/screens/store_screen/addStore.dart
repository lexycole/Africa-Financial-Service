import 'package:flutter/material.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/store_modal.dart';
import 'package:xcrowme/screens/store_screen/index.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddStoreScreen extends StatefulWidget {
  final String sellerId;

  AddStoreScreen({required this.sellerId});

  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final LoginController loginController = Get.find<LoginController>();

  Future<void> _addStore() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String name = _nameController.text;
    final String phone = '+234${_phoneController.text}';
    final String link = _linkController.text;

    try {
      final createStoreUrl = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createStore);

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': 'gi6paFHGatKXClIE',
        'Api-Sec-Key':
            'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      final Map<String, dynamic> body = {
        'name': name,
        'phone': phone,
        'link': link,
        'seller_uid': widget.sellerId, // Use the passed sellerId
      };

      final http.Response response = await http.post(
        createStoreUrl,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final StoreModel store = StoreModel(
          name: name,
          phone: phone,
          link: link,
          seller_uid: widget.sellerId,  
          
        );

        Get.to(() => StoreScreen(
              newStores: [store],
            )); 
            
        showSuccessSnackBar("Store Created Successfully", title: "Perfect");
      } else {
        showFailureSnackBar('Error', title: "Failed to create store");
      }
    } catch (e) {
      print(e.toString());
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return     
    Scaffold(
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
                        "Add Store",
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
                    Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: 'Store-Name',
                          icon: Icons.account_circle_outlined,
                          textController: _nameController),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: '+234**********',
                          icon: Icons.phone,
                          textController: _phoneController),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: 'Link-Name',
                          icon: Icons.description_outlined,
                          textController: _linkController),
                      SizedBox(height: Dimensions.height45),
                      GestureDetector(
                          onTap: _addStore,
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
                                      text: "Add",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white)))),
                    ],
                  ))
                 ]
      ),
    )))])));}}