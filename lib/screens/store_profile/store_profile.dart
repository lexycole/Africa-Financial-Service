import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/update_stores_detail_modal.dart';
import 'package:xcrowme/screens/products_screen/create_products.dart';
import 'package:xcrowme/screens/store_screen/index.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class StoreProfileScreen extends StatefulWidget {
  final String sellerId;
  final String link;
  final String initialValue;

  const StoreProfileScreen({
    Key? key,
    required this.initialValue,
    required this.sellerId,
    required this.link,
  }) : super(key: key);

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  final LoginController loginController =
      Get.find();
  late TextEditingController _nameController;
  late TextEditingController _linkController;

  bool _isEditing = false;
  bool _isDoneVisible = false;

  @override
  void initState() {
    super.initState();
    fetchStoreDetail();
    _nameController = TextEditingController(text: widget.initialValue);
    _linkController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      _isDoneVisible = _isEditing; 
    });
  }

  Future<void> fetchStoreDetail() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': '',
      'Api-Sec-Key': '',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.storeDetail
              .replaceFirst('{link}', widget.link));

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        String name = jsonData['name'];
        String link = jsonData['link'];
        setState(() {
          _nameController.text = name;
          _linkController.text = link;
        });
      } else {
        throw jsonDecode(response.body)['data']['detail'];
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  Future<void> updateStoreDetail() async {
    final String name = _nameController.text;
    final String link = _linkController.text;

    final Map<String, dynamic> body = {
      'name': name,
      'link': link,
    };

    try {
      final LoginController loginController = Get.find<LoginController>();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': '',
        'Api-Sec-Key':
            '',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };
      final url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.storeUpdate
              .replaceFirst('{link}', widget.link));

      final http.Response response = await http.put(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UpdateStoresDetailModel updateStoreDetail =
            UpdateStoresDetailModel(
                uid: responseData['data'], name: name, link: link);
        showSuccessSnackBar("Store Updated! Successfully", title: "Perfect");
      }
    } catch (e) {
      e.toString();
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  
  Future<void> deleteStoreDetail() async {
    bool confirmDeletion = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Store'),
            content: Text('Are you sure you want to delete this store?'),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true),
                child: Text('Continue'),
              ),
            ],
          ),
        ) ??
        false; 

    if (!confirmDeletion) {
      return;
    }

    try {
      final LoginController loginController = Get.find<LoginController>();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': 'gi6paFHGatKXClIE',
        'Api-Sec-Key':
            'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };
      final url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.deleteStore
              .replaceFirst('{link}', widget.link));

      final http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 204) {
        showSuccessSnackBar("Store Deleted Successfully", title: "Deleted!");
        Get.offAll(StoreScreen(
          newStores: [],
        ));
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      e.toString();
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
      child:Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 25.0),
                child: Column(children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 500,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: AppColors.AppBannerColor),
                                    onPressed: () => Get.offAll(BottomTab(initialIndex: 1)),
                                  ),
                                  Center(
                                    child: Text(
                                      "Your Store",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.AppBannerColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:IconButton(
                                          icon: Icon(
                                            Icons.add_shopping_cart_outlined, 
                                            color: AppColors.AppBannerColor, 
                                            size: 40),
                                          onPressed: () {
                                            Get.to(() => CreateProducts( 
                                              initialValue: '',
                                              link: '', 
                                              sellerId: ''),
                                              transition: Transition.rightToLeft
                                            );
                                          },
                                  ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 35),
                              ),
                              SizedBox(width:5.0), 
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: toggleEdit,
                                    icon: Icon(Icons.edit,
                                        color: AppColors.AppBannerColor),
                                  ),
                                  IconButton(
                                    onPressed: deleteStoreDetail,
                                    icon: Icon(Icons.delete,
                                        color:
                                            Color.fromARGB(255, 255, 89, 89)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          if (_isEditing)
                            Column(children: [
                              GestureDetector(
                                onTap: toggleEdit,
                                child: TextField(
                                  controller: _nameController,
                                  enabled: _isEditing,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    disabledBorder: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _linkController,
                                enabled: _isEditing,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  disabledBorder: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                            ]),
                          if (!_isEditing)
                            Column(
                              children: [
                                Card(
                                  elevation: 2,
                                  child: GestureDetector(
                                    child: TextField(
                                      controller: _nameController,
                                      enabled: false,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Card(
                                  elevation: 2,
                                  child: TextField(
                                    controller: _linkController,
                                    enabled: false,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Visibility(
                            visible: _isDoneVisible,
                            child: Container(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_isEditing) {
                                    updateStoreDetail();
                                  }
                                },
                                child: Text("Done"),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: AppColors.AppBannerColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // if (!_isEditing)
                          //   Container(
                          //     padding: const EdgeInsets.only(top: 20.0),
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Get.to(
                          //             () => CreateProducts(
                          //                   initialValue: '',
                          //                   link: '',
                          //                   sellerId: '',
                          //                 ),
                          //             // ProductsList(
                          //             //       sellerId: widget.sellerId,
                          //             //       initialValue: '',
                          //             //       link: '', newProducts: [],
                          //             //     ),
                          //             transition: Transition.rightToLeft);
                          //       },
                          //       child: Container(
                          //         height: 50,
                          //         decoration: BoxDecoration(
                          //           color: AppColors.AppBannerColor,
                          //           borderRadius: BorderRadius.circular(30),
                          //         ),
                          //         child: Center(
                          //           child: Text(
                          //             "Add New Product",
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   )
                        ],
                      ),
                    ),
                  )
                ]
              )
            )
          )
      )
    );
  }
}
