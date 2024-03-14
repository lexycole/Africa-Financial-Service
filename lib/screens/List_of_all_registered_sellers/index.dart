import 'package:flutter/material.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/sellers_list_modal.dart';
import 'package:xcrowme/models/sellers_modal.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/create_seller_screen/index.dart';
import 'package:xcrowme/screens/profile_screen/index.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class ListOfAllSellersScreen extends StatefulWidget {
  final List<SellerModel> newSellers;
  final String sellerId;
  const ListOfAllSellersScreen({Key? key, required this.newSellers, required this.sellerId,}): super(key: key);

  @override
  State<ListOfAllSellersScreen> createState() => _ListOfAllSellersScreenState();
}

class _ListOfAllSellersScreenState extends State<ListOfAllSellersScreen> {
  final LoginController loginController = Get.find(); 
  List<SellersListModel> listSellers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSellersList();
  }

  Future<void> fetchSellersList() async {
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
        var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.sellersList);
        var response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
          setState(() {
            if (jsonData.isEmpty) {
              listSellers = [];
              isLoading = false;
            } else {
              List<SellersListModel> fetchedSellers = jsonData.map((item) {
                return SellersListModel(
                  uid: item['uid'],
                  firstName: item['first_name'],
                  lastName: item['last_name'],
                  phone: item['phone'],
                  dob: item['dob'],
                  stores: item['stores'],
                  balance: item['balance'],
                );
              }).toList();

              if (widget.newSellers.isNotEmpty) {
                List<SellersListModel> newSellersList =
                    widget.newSellers.map((seller) {
                  return SellersListModel(
                    uid: seller.uid,
                    firstName: seller.firstName,
                    lastName: seller.lastName,
                    phone: seller.phone,
                    dob: seller.dob,
                    stores: 0,
                    balance: 0, 
                  );
                }).toList();
                listSellers = [...newSellersList.reversed, ...fetchedSellers];
              } else {
                listSellers = fetchedSellers;
              }
              isLoading = false;
            }
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

  @override
  Widget build(BuildContext context) {
    return  IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () { Get.offAll(BottomTab(initialIndex: 1)); },
        ),
        backgroundColor: AppColors.AppBannerColor,
        title: const Text('Registered Sellers'),
      ),
      body: 
      isLoading
        ? Center(
            child: CircularProgressIndicator(color: AppColors.AppBannerColor),
          )
        : listSellers.isEmpty ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.store),
                  SizedBox(height: 10),
                  Text("No registered seller"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => CreateSellerScreen(),
                          transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: [
                            Text("Add"),
                            Icon(Icons.add),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ):
                  ListView.builder( 
                          physics: const BouncingScrollPhysics(),
                          itemCount: listSellers.length,
                          itemBuilder: (context, index) {
                            final seller = listSellers[index];
                            return Card(
                              child: ListTile(
                                title: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Text(
                                              '${seller.firstName} ${seller.lastName}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color:
                                                    Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${seller.phone}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 26),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius
                                                  .circular(10),
                                          border: Border.all(
                                            color:
                                                Colors.grey[400]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                            Icons.arrow_forward),
                                      ),
                                    ],
                                  ),
                                ),
                                leading: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300],
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.account_circle_outlined,
                                    size: 35,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () { Get.to(() => ProfileScreen(
                                            initialValue: '',
                                            sellerId: seller.uid,),
                                      transition: Transition.rightToLeft);
                                },
                              ),
                            );
                          },                        
                      ),             
                                  
                                
          
    ));
  
  }
}
