import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/users_controller.dart';
import 'package:xcrowme/models/store_list_modal.dart';
import 'package:xcrowme/models/store_modal.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:xcrowme/screens/history_screen/index.dart';
import 'package:xcrowme/screens/new_store/index.dart';
import 'package:xcrowme/screens/store_profile/store_profile.dart';
import 'package:xcrowme/screens/store_screen/addStore.dart';
import 'package:xcrowme/screens/store_screen/index.dart';
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
  bool isLoading = false; // Declare state

  @override
  void initState() {
    super.initState();
    fetchAvailableFunds();
    fetchStoresList();
  }

// Fetch Available Funds
  Future<void> fetchAvailableFunds() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.balance); // Replace with your API endpoint

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        var balance = double.parse(jsonData['balance'].toString());

        // Update the balance in the LoginController
        loginController.balance.value = balance;
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }

// Fetch Stores List
  Future<void> fetchStoresList() async {
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
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.storesList);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData =
            jsonDecode(response.body)['data']['results'] as List<dynamic>;
        // Create a list to hold the fetched STORES
        List<StoreListModel> fetchedStoresList = jsonData.map((item) {
          return StoreListModel(
            uid: item['uid'] ?? '', // Provide a default value if null
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
      // showFailureSnackBar('Error', title: e.toString());
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
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 25, left: 20.0, right: 20.0),
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
                      toTitleCase(controller.user?.firstName ?? ''),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(234, 0, 0, 0),
                      ),
                    ),
                  ),
                  GetBuilder<UserController>(
                  builder: (controller) => Text(
                    '+234 ${controller.user?.phoneNumber ?? ''}',
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
                    // onTap: () => Get.to(() => StoreScreen(newStores: [],)),
                    onTap: () => Get.offAll(BottomTab(initialIndex: 3)),
                    child: Icon(Icons.notifications,
                        color: AppColors.AppBannerColor, size: 45),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        // Card Details
        Center(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.baseline, 
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Welcome ", style: TextStyle(fontSize: 26)),
                      GetBuilder<UserController>(
                        builder: (controller) => Text(
                          toTitleCase(controller.user?.firstName ?? ''),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(234, 0, 0, 0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Card(
                  elevation: 10.0,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, top: 50, bottom: 50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 5.0),
                            Text("Avaliable funds",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 5.0),
                            Obx(
                              () => Text(
                                loginController.balance.value
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => WithdrawScreen());
                                },
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
                          ])),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0),
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                child: InkWell(
                  splashColor: Color.fromARGB(255, 5, 20, 68),
                  onTap: () => Get.to(() => WithdrawScreen()),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.AppBannerColor,
                          child: Icon(Icons.payments,
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
              ),

              // New Store Icon
              InkWell(
                splashColor: Color.fromARGB(255, 5, 20, 68),
                onTap: () => Get.to(() => NewStoreScreen()),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.AppBannerColor,
                        child: Icon(Icons.add_business,
                            color: Colors.white, size: 30),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "New Store",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),
              ),

              // List of Stores Icon
              InkWell(
                splashColor: Color.fromARGB(255, 5, 20, 68),
                onTap: () => Get.to(() => StoreScreen(
                      newStores: [],
                    )),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.AppBannerColor,
                        child: Icon(Icons.store, color: Colors.white, size: 30),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "List of Store",
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
        // LIST OF USERS
         Expanded( // Add Expanded to ensure the Column takes available space
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
                          padding: const EdgeInsets.all(16),
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
                                    onPressed: () {
                                      Get.to(
                                          () => AddStoreScreen(sellerId: ''));
                                    },
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
                                // User One
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: constraints.maxHeight,
                                              child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
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
                                                                    color: Colors
                                                                            .grey[
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

                        // User One
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: Colors.green,
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("Timothy macho",
                        //                     style:
                        //                         TextStyle(fontSize: 18)),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           IconButton(
                        //             onPressed: () {
                        //               Get.to(
                        //                 () => StoreScreen(newStores: [],),
                        //               );
                        //             },
                        //             icon: Icon(Icons.store),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   height: 1.0,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // // User Two
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: Colors.brown,
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("Micheal Tinubu",
                        //                     style:
                        //                         TextStyle(fontSize: 18)),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           IconButton(
                        //             onPressed: () {
                        //               Get.to(
                        //                 () => StoreScreen(newStores: [],),
                        //               );
                        //             },
                        //             icon: Icon(Icons.store),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   height: 1.0,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // // User Three
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: Colors.blue,
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("Ijeoma Ifeanyi",
                        //                     style:
                        //                         TextStyle(fontSize: 18)),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           IconButton(
                        //             onPressed: () {
                        //               Get.to(
                        //                 () => StoreScreen(newStores: [],),
                        //               );
                        //             },
                        //             icon: Icon(Icons.store),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   height: 1.0,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // // User Four
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: Colors.purple,
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("IBAYC tems",
                        //                     style:
                        //                         TextStyle(fontSize: 18)),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           IconButton(
                        //             onPressed: () {
                        //               Get.to(
                        //                 () => StoreScreen(newStores: [],),
                        //               );
                        //             },
                        //             icon: Icon(Icons.store),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   height: 1.0,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // // User Five
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: Colors.grey,
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("User Five",
                        //                     style:
                        //                         TextStyle(fontSize: 18)),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           IconButton(
                        //             onPressed: () {
                        //               Get.to(
                        //                 () => StoreScreen(newStores: [],),
                        //               );
                        //             },
                        //             icon: Icon(Icons.store),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   height: 1.0,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // // User Six
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: Colors.grey,
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Expanded(
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("User Six",
                        //                     style:
                        //                         TextStyle(fontSize: 18)),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           IconButton(
                        //             onPressed: () {
                        //               Get.to(() => StoreScreen(newStores: [],));
                        //             },
                        //             icon: Icon(Icons.store),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   height: 1.0,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                      ))
                  ])),
        
        )]),
    ));
  }
}
