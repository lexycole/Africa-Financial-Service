import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/users_controller.dart';
import 'package:xcrowme/models/store_list_modal.dart';
import 'package:xcrowme/models/store_modal.dart';
import 'package:xcrowme/screens/create_seller_screen/index.dart';
import 'package:xcrowme/screens/store_profile/store_profile.dart';
import 'package:xcrowme/screens/store_screen/addStore.dart';
import 'package:xcrowme/screens/withdraw_screen/index.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xcrowme/tabs/bottom_tabs.dart';

class HomeScreen extends StatefulWidget {
  final List<StoreModel> newStores;
  const HomeScreen({Key? key, required this.newStores}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.find<LoginController>();
  final UserController userController = Get.put(UserController());
  List<StoreListModel> listStores = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAvailableFunds();
    fetchStoresList();
  }


  Future<void> fetchAvailableFunds() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': '',
      'Api-Sec-Key': '',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.balance);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        var balance = double.parse(jsonData['balance'].toString());
        loginController.balance.value = balance;
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }


  Future<void> fetchStoresList() async {
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
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.storesList);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data']['results'] as List<dynamic>;
        List<StoreListModel> fetchedStoresList = jsonData.map((item) {
          return StoreListModel(
            uid: item['uid'] ?? '', 
            name: item['name'] ?? '',
            phone: item['phone'] ?? '',
            link: item['link'] ?? '',
          );
        }).toList();

        setState(() {
          if (widget.newStores.isNotEmpty) {
            List<StoreListModel> newStoresList = widget.newStores.map((store) {
              return StoreListModel(
                uid: '',
                phone: store.phone,
                name: store.name,
                link: store.link,
              );
            }).toList();
            listStores = [...newStoresList.reversed, ...fetchedStoresList];
          } else {
            listStores = fetchedStoresList;
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


String toTitleCase(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');
}

  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
    child: Scaffold(
        body: Container(
        padding: EdgeInsets.only(top: 25, left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 35),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<UserController>(
                      builder: (controller) => Text(
                        toTitleCase('Hello, ${controller.user?.firstName ?? ''}'),
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(234, 0, 0, 0),
                        ),
                      ),
                    ),
                
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Color.fromARGB(255, 5, 20, 68),
                      onTap: () => Get.offAll(BottomTab(initialIndex: 1)),
                      child: Icon(Icons.notifications,
                          color: AppColors.AppBannerColor, size: 45),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total Balance",
                              style: TextStyle(
                                color: Color.fromARGB(234, 0, 0, 0),
                                fontSize: 21,
                                
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.error_outline,
                                color: Color.fromARGB(255, 5, 20, 68),
                                size: 20,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Total Balance"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min, 
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Your total balance is the sum of the money in your account including your sellers.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                              SizedBox(height: 10),
                                          Text("#100,000"),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); 
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          "#100,000.00",
                          style: TextStyle(
                            color: Color.fromARGB(234, 0, 0, 0),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),            
                  SizedBox(height: 2.5),
                  Card(
                    elevation: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Padding(
                        padding:EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 5.0),
                              Text("Avaliable funds",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5.0),
                              Obx(() => Text(loginController.balance.value.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: GestureDetector(
                                  onTap: () {Get.to(() => WithdrawScreen());},
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.AppBannerColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Withdraw",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]
                          )
                      ),
                  ),
                ],
              ),        
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Store link copied"), 
                            duration: Duration(seconds: 10),
                          ),
                        );
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.AppBannerColor,
                              child: Icon(Icons.content_copy_outlined,
                                  color: Colors.white, size: 30),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Store Link",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ]),
                    ),
                  SizedBox(width: 10.0),
                  InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () => Get.to(() => CreateSellerScreen()),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.AppBannerColor,
                            child: Icon(Icons.person_add,
                                color: Colors.white, size: 30),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Create a seller",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded( 
              child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 20),
                      Container(
                        child: Text(
                          "Recent Stores",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (isLoading)
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColors.AppBannerColor,
                          ),
                        )
                      else if (listStores.isEmpty)
                        Center(
                            child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.store),
                                SizedBox(height: 10),
                                Text("No recent stores created"),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () { Get.to(() => AddStoreScreen(sellerId: '')); },
                                      child: Row(
                                        children: [
                                          Text("Create"),
                                          Icon(Icons.add),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                      else
                        Expanded(child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: constraints.maxHeight,
                                                child: ListView.builder(
                                                  physics: BouncingScrollPhysics(),
                                                  itemCount: listStores.length,
                                                  itemBuilder: (context, index) {
                                                    final store =
                                                        listStores[index];
                                                    return Card(
                                                      child: ListTile(
                                                        title: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
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
                                                                      '${store.name}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '${store.link}'),
                                                                    Text(
                                                                      '${store.phone}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(width: 26),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey[200],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Colors.grey[
                                                                          400]!,
                                                                      width: 1),
                                                                ),
                                                                child: Icon(Icons
                                                                    .arrow_forward),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        leading: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            color:
                                                                Colors.grey[300],
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Icon(
                                                            Icons.store_outlined,
                                                            size: 35,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Get.to(
                                                            () =>
                                                                StoreProfileScreen(
                                                              sellerId: '',
                                                              link: '',
                                                              initialValue: '',
                                                            ),
                                                            transition: Transition
                                                                .rightToLeft,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },

                        
                        )
                        )
                    ])),
          )]),
      )));
  }
}
