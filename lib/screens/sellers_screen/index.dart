import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/List_of_all_registered_sellers/index.dart';
// import 'package:xcrowme/screens/account_screen/index.dart';
import 'package:xcrowme/screens/create_seller_screen/index.dart';
import 'package:xcrowme/screens/connect_seller_form/index.dart';
import 'package:xcrowme/screens/store_screen/index.dart';
import 'package:xcrowme/screens/withdraw_screen/index.dart';
import 'package:xcrowme/utils/colors.dart';

class SellersScreen extends StatelessWidget {
  const SellersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 25.0),
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Row(children: [
                        Text("Sellers",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Spacer(),
                      ])),

                  SizedBox(height: 5.0),
                  // 01. Create a seller
                  InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () => Get.to(() => CreateSellerScreen(),
                        transition: Transition.rightToLeftWithFade),
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.AppBannerColor,
                                    child: Icon(Icons.person_add,
                                        color: Colors.white, size: 35),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Create a seller",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 30),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  // Connect Seller
                  InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () => Get.to(() => ConnectSellerFormScreen(),
                        transition: Transition.rightToLeftWithFade),
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.AppBannerColor,
                                    child: Icon(Icons.handshake,
                                        color: Colors.white, size: 35),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Connect seller",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 30),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  // 03. List of users
                  InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () => Get.to(
                        () => ListOfAllSellersScreen(
                              newSellers: [],
                            ),
                        transition: Transition.rightToLeftWithFade),
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.AppBannerColor,
                                    child: Icon(Icons.group,
                                        color: Colors.white, size: 35),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("List of Sellers",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 30),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),

                  // 02. Withdraw
                  InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () => Get.to(() => WithdrawScreen(),
                        transition: Transition.rightToLeftWithFade),
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.AppBannerColor,
                                    child: Icon(Icons.payments,
                                        color: Colors.white, size: 35),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Withdraw",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 30),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  // 05. Amount of stores
                  InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () => Get.to(
                        () => StoreScreen(
                              newStores: [],
                            ),
                        transition: Transition.rightToLeftWithFade),
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.AppBannerColor,
                                    child: Icon(Icons.store,
                                        color: Colors.white, size: 35),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Amount of Stores",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 30),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  // 06. Global Link store
                  // InkWell(
                  //   splashColor: Color.fromARGB(255, 5, 20, 68),
                  //   onTap: () => Get.to(() => GlobalStoreLinkScreen()),
                  //   child: Card(
                  //     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //     child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             CircleAvatar(
                  //               radius: 30,
                  //               backgroundColor: AppColors.AppBannerColor,
                  //               child: Icon(Icons.other_houses_sharp,
                  //                   color: Colors.white, size: 35),
                  //             ),
                  //             SizedBox(width: 10),
                  //             Expanded(
                  //               child: Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text("Global Store",
                  //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(width: 10),
                  //             IconButton(
                  //               onPressed: () {
                  //                 Get.to(() => GlobalStoreLinkScreen(), transition: Transition.leftToRight);
                  //               },
                  //               icon: Icon(
                  //                 Icons.arrow_forward_ios,
                  //                 color: Colors.black,
                  //                 size: 30),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   )
                  // ),
                  // ),
                  // 07. Profile
                  // InkWell(
                  //   splashColor: Color.fromARGB(255, 5, 20, 68),
                  //   onTap: () => Get.to(() => AccountScreen(),
                  //       transition: Transition.rightToLeftWithFade),
                  //   child: Card(
                  //       margin: const EdgeInsets.symmetric(
                  //           vertical: 10, horizontal: 10),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 CircleAvatar(
                  //                   radius: 30,
                  //                   backgroundColor: AppColors.AppBannerColor,
                  //                   child: Icon(Icons.person,
                  //                       color: Colors.white, size: 35),
                  //                 ),
                  //                 SizedBox(width: 10),
                  //                 Expanded(
                  //                   child: Row(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text("Account",
                  //                           style: TextStyle(
                  //                               fontSize: 18,
                  //                               fontWeight: FontWeight.bold)),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: 10),
                  //                 Icon(Icons.arrow_forward_ios,
                  //                     color: Colors.black, size: 30),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       )),
                  // ),
                  // 08. Connect Sellers
                  // 07. Properties
                  //   InkWell(
                  //     splashColor: Color.fromARGB(255, 5, 20, 68),
                  //     onTap: () => Get.to(() => PropertiesScreen()),
                  //     child: Card(
                  //       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //       child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           padding: const EdgeInsets.all(10.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               CircleAvatar(
                  //                 radius: 30,
                  //                 backgroundColor: AppColors.bgBtnColor,
                  //                 child: Icon(Icons.description,
                  //                     color: Colors.white, size: 35),
                  //               ),
                  //               SizedBox(width: 10),
                  //               Expanded(
                  //                 child: Row(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text("Properties",
                  //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(width: 10),
                  //               IconButton(
                  //                 onPressed: () {
                  //                   Get.to(() => PropertiesScreen(), transition: Transition.leftToRight);
                  //                 },
                  //                 icon: Icon(
                  //                   Icons.arrow_forward_ios,
                  //                   color: Colors.black,
                  //                   size: 30),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  //   ),
                  // ),
                ]))));
  }
}
