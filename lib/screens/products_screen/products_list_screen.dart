import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/create_products_model.dart';
import 'package:xcrowme/models/products_list_modal.dart';
import 'package:xcrowme/screens/payment_screen/checkout_screen.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class ProductsList extends StatefulWidget {
  final List<CreateProductModel> newProducts;
  final String sellerId;
  final String link;
  final String initialValue;

  const ProductsList({
    Key? key,
    required this.initialValue,
    required this.sellerId,
    required this.link,
    required this.newProducts,
  }) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final LoginController loginController = Get.find(); 
  List<ProductsListModal> listProducts = [];
  bool isLoading = false; 

  @override
  void initState() {
    super.initState();
    fetchProductsList(); 
  }

  Future<void> fetchProductsList() async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': '',
      'Api-Sec-Key': '',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.productsList);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data']['results'] as List<dynamic>;
        List<ProductsListModal> fetchedProductsList = jsonData.map((item) {
          return ProductsListModal(
            uid: item['uid'] ?? '',
            label: item['label'] ?? '',
            price: item['price'] ?? '',
            description: item['description'] ?? '',
            quantity: item['quantity'] ?? '',
          );
        }).toList();

        setState(() {
          if (widget.newProducts.isNotEmpty) {
            List<ProductsListModal> newProductsList =
                widget.newProducts.map((product) {
              return ProductsListModal(
                uid: '',
                label: product.label,
                price: product.price,
                description: product.description,
                quantity: product.quantity,
              );
            }).toList();
            listProducts = [
              ...newProductsList.reversed,
              ...fetchedProductsList
            ];
          } else {
            listProducts = fetchedProductsList;
          }
          isLoading = false;
        });
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {

  var filteredProducts = listProducts.where((product) {
    return product.label.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();

    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: Dimensions.height30),
                padding: EdgeInsets.all(Dimensions.width20),
                child: Column(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: AppColors.AppBannerColor),                              
                                onPressed:() => Get.back()
                              ),
                              Center(
                                child: Text(
                                  "Your Product",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 15),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search, color: AppColors.AppBannerColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0), 
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: AppColors.AppBannerColor, width: 2.0), 
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() { searchQuery = value; });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                              if (isLoading)
                                Center(
                                    child: CircularProgressIndicator(color: AppColors.AppBannerColor),
                                  )
                              else if (filteredProducts.isEmpty && searchQuery.isNotEmpty)
                                    Center(
                                      child: Text(
                                        'No product found',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    )
                              else
                                ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: filteredProducts.length,
                                      itemBuilder: (context, index) {
                                        var product = filteredProducts[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.AppBannerColor, width: 3),
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.label,
                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      product.description,
                                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      product.price.toString(),
                                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      product.quantity.toString(),
                                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () { Get.to(()=> CheckOutScreen());},
                                                child: Text('Buy'),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white, 
                                                  backgroundColor: AppColors.AppBannerColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ]
                                )
                            )
                        ]
                      )
                    )
                  )
      )
    );
  }
}
