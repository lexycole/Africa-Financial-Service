import 'package:flutter/material.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/sellers_list_modal.dart';
import 'package:xcrowme/models/sellers_modal.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/profile_screen/index.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListOfAllSellersScreen extends StatefulWidget {
  final List<SellerModel> newSellers;
  const ListOfAllSellersScreen({Key? key, required this.newSellers})
      : super(key: key);

  @override
  State<ListOfAllSellersScreen> createState() => _ListOfAllSellersScreenState();
}

class _ListOfAllSellersScreenState extends State<ListOfAllSellersScreen> {
  final LoginController loginController =
      Get.find(); 
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
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints
              .authEndpoints.sellersList);

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData =
            jsonDecode(response.body)['data']['results'] as List<dynamic>;
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

        setState(() {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.offAll(BottomTab(
                initialIndex: 1)); 
          },
        ),
        backgroundColor: AppColors.AppBannerColor,
        title: const Text('Registered Sellers'),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                    onPressed: () {},
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
          ),
        ),
      ),
      // isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(color: AppColors.AppBannerColor),
      //       )
      //     : LayoutBuilder(
      //         builder: (context, constraints) {
      //           return SingleChildScrollView(
      //             child: Container(
      //               width: double.maxFinite,
      //               padding: EdgeInsets.all(20),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   // Screen Title
      //                   Center(
      //                       child: CircleAvatar(
      //                     radius: 30,
      //                     backgroundColor: AppColors.bgBtnColor,
      //                     child:
      //                         Icon(Icons.group, color: Colors.white, size: 35),
      //                   )),
      //                   SizedBox(height: 20),
      //                   Container(
      //                     alignment: Alignment.center,
      //                     child: Text(
      //                       "Registered sellers",
      //                       style: TextStyle(
      //                           fontSize: 24,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.black),
      //                     ),
      //                   ),
      //                   SizedBox(height: 10),
      //                   // User One
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       Container(
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Expanded(
      //                               child: SizedBox(
      //                                 height: constraints
      //                                     .maxHeight, // Set a fixed height
      //                                 child: ListView.builder(
      //                                   physics: const BouncingScrollPhysics(),
      //                                   itemCount: listSellers.length,
      //                                   itemBuilder: (context, index) {
      //                                     final seller = listSellers[index];
      //                                     return Card(
      //                                       child: ListTile(
      //                                         title: Container(
      //                                           padding: EdgeInsets.all(8),
      //                                           child: Row(
      //                                             mainAxisAlignment:
      //                                                 MainAxisAlignment
      //                                                     .spaceBetween,
      //                                             children: [
      //                                               Expanded(
      //                                                 child: Column(
      //                                                   crossAxisAlignment:
      //                                                       CrossAxisAlignment
      //                                                           .start,
      //                                                   children: [
      //                                                     Text(
      //                                                       '${seller.firstName} ${seller.lastName}',
      //                                                       style: TextStyle(
      //                                                         fontSize: 18,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .bold,
      //                                                         color:
      //                                                             Colors.black,
      //                                                       ),
      //                                                     ),
      //                                                     Text(
      //                                                       '${seller.phone}',
      //                                                       style: TextStyle(
      //                                                         fontSize: 16,
      //                                                         color:
      //                                                             Colors.black,
      //                                                       ),
      //                                                     ),
      //                                                   ],
      //                                                 ),
      //                                               ),
      //                                               SizedBox(width: 26),
      //                                               Container(
      //                                                 decoration: BoxDecoration(
      //                                                   color: Colors.grey[200],
      //                                                   borderRadius:
      //                                                       BorderRadius
      //                                                           .circular(10),
      //                                                   border: Border.all(
      //                                                     color:
      //                                                         Colors.grey[400]!,
      //                                                     width: 1,
      //                                                   ),
      //                                                 ),
      //                                                 child: Icon(
      //                                                     Icons.arrow_forward),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         ),
      //                                         leading: Container(
      //                                           decoration: BoxDecoration(
      //                                             borderRadius:
      //                                                 BorderRadius.circular(8),
      //                                             color: Colors.grey[300],
      //                                           ),
      //                                           padding: EdgeInsets.all(8),
      //                                           child: Icon(
      //                                             Icons.account_circle_outlined,
      //                                             size: 35,
      //                                             color: Colors.black,
      //                                           ),
      //                                         ),
      //                                         onTap: () {
      //                                           Get.to(
      //                                               () => ProfileScreen(
      //                                                     initialValue: '',
      //                                                     sellerId: seller.uid,
      //                                                   ),
      //                                               transition:
      //                                                   Transition.rightToLeft);
      //                                         },
      //                                       ),
      //                                     );
      //                                   },
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       ),
    );
  }
}
