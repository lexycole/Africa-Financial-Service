import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/create_products_model.dart';
import 'package:xcrowme/screens/products_screen/products_list_screen.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class CreateProducts extends StatefulWidget {
  final String sellerId;
  final String link;
  final String initialValue;
  const CreateProducts({
    Key? key,
    required this.initialValue,
    required this.sellerId,
    required this.link,
  }) : super(key: key);

  @override
  State<CreateProducts> createState() => _CreateProductsState();
}

class _CreateProductsState extends State<CreateProducts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  final LoginController loginController = Get.find<LoginController>();

  Future<void> _createProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String label = _labelController.text;
    final int price = int.parse(_priceController.text);
    final String description = _descriptionController.text;
    final int quantity = int.parse(_quantityController.text);
    final String link = _linkController.text;

    try {
      final createProductUrl = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createProduct);
      print('$createProductUrl:create produc url');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': '',
        'Api-Sec-Key':
            '',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      final Map<String, dynamic> body = {
        'label': label,
        'price': price,
        'description': description,
        'quantity': quantity,
        'unlimited': true,
        'link': link,
        'seller_uid': widget.sellerId,
      };

      final http.Response response = await http.post(
        createProductUrl,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final CreateProductModel product = CreateProductModel(
          label: label,
          price: price,
          description: description,
          quantity: quantity,
          link: link,
          seller_uid: widget.sellerId,
        );

        Get.to(() => ProductsList(
              newProducts: [product],
              initialValue: '',
              link: '',
              sellerId: '',
            ));
          showSuccessSnackBar("Product Created Successfully", title: "Perfect");
      } else {
        showFailureSnackBar('Error');
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.AppBannerColor,
        title: const Text('Create Your Product'),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 28,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: 'Your label Name',
                          icon: Icons.label_outlined,
                          textController: _labelController),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: 'Your price tag',
                          icon: Icons.payments_outlined,
                          textController: _priceController),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: 'Your Product description',
                          icon: Icons.description_outlined,
                          textController: _descriptionController),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                          hintText: 'Number Quantity',
                          icon: Icons.production_quantity_limits_outlined,
                          textController: _quantityController),
                      SizedBox(height: Dimensions.height20),
                      Text('Enter your store link name from create store screen'),
                      SizedBox(height: Dimensions.height10),
                      AppTextField(
                          hintText: 'Store-Link-Name',
                          icon: Icons.link,
                          textController: _linkController),
                      SizedBox(height: Dimensions.height45),
                      ElevatedButton(
                        onPressed: _createProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.AppBannerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          fixedSize: Size(
                            Dimensions.screenWidth / 10 * 9,
                            Dimensions.screenHeight / 10,
                          ),
                        ),
                        child: BigText(
                        text: "Create",
                        size: Dimensions.font20 + Dimensions.font20 / 2,
                        color: Colors.white,
                      ),
                    )

                    ],
                  )))
        ],
      ),
      )
    );
  }
}
