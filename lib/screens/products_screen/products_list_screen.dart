import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/create_products_model.dart';
import 'package:xcrowme/models/products_list_modal.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final LoginController loginController =
      Get.find(); // Get the instance of LoginController
  List<ProductsListModal> listProducts = [];
  bool isLoading = false; // Declare state

  @override
  void initState() {
    super.initState();
    fetchProductsList(); // Call the function to fetch data on widget initialization
  }

  Future<void> fetchProductsList() async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.productsList);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData =
            jsonDecode(response.body)['data']['results'] as List<dynamic>;
        // Create a list to hold the fetched Products
        List<ProductsListModal> fetchedProductsList = jsonData.map((item) {
          return ProductsListModal(
            uid: item['uid'] ?? '', // Provide a default value if null
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
          isLoading = false; // set loading to false
        });
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // showFailureSnackBar('Error', title: e.toString());
    }
  }

// Tacking the search query, searchQuery
  String searchQuery = '';

  List<ProductsListModal> get filteredProducts {
    if (searchQuery.isNotEmpty) {
      return listProducts
          .where((product) => product.label.contains(searchQuery))
          .toList();
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: Dimensions.height30),
                padding: EdgeInsets.all(Dimensions.width20),
                child: Column(children: [
                  // Profile Widget
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Align contents to start and end
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: AppColors.AppBannerColor),
                                onPressed: () =>
                                    Get.offAll(BottomTab(initialIndex: 1)),
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
                  // User Information
                  Padding(
                      padding:
                          EdgeInsets.all(8.0), // Add desired padding values
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      'Search', // Placeholder text for the search input
                                  prefixIcon: Icon(Icons
                                      .search), // Search icon at the beginning of the input field
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Define the border radius here
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Define the border radius here
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.0), // Define the border radius here
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.AppBannerColor),
                                  )
                                : LayoutBuilder(
                                    builder: (context, constraints) {
                                    return SingleChildScrollView(
                                        child: Container(
                                            width: double.maxFinite,
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    listProducts.map((product) {
                                                  return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .AppBannerColor,
                                                                width: 3),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              product.label,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          123,
                                                                          123,
                                                                          123)),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                product
                                                                    .description,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                                maxLines: 5,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              product.price
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 5,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              product.quantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 5,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ]);
                                                }).toList())));
                                  }),
                          ]))
                ]))));
  }
}
