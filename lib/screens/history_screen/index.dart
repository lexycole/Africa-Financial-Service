import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/List_of_all_registered_sellers/index.dart';
import 'package:xcrowme/utils/dimensions.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SingleChildScrollView(
                child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(left:20, right:20),
                      margin: EdgeInsets.only(top: 55.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                            // Screen Title
                            Container(
                              padding: const EdgeInsets.only(left:10.0, top:20.0, bottom:20.0), 
                              child: Text("History", style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold)),
                              ),
                            // 01. Recently Add User
                            InkWell(
                              splashColor: Color.fromARGB(255, 5, 20, 68),
                              onTap: () {
                                 Get.to(() => ListOfAllSellersScreen(newSellers:[]), transition: Transition.leftToRight);
                              },
                                child:Card(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Color.fromARGB(255, 0, 115, 177),
                                            child: Icon(
                                              Icons.groups,
                                              color: Colors.white, 
                                              size: 35),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Recently Added User",
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                            SizedBox(width: 10),
                                          IconButton(
                                            onPressed: () {
                                              Get.to(() => ListOfAllSellersScreen( newSellers: [],),);
                                            }, 
                                            icon: Icon(
                                              Icons.arrow_forward_ios, 
                                              color: Colors.black, 
                                              size: 30),
                                          ),  
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                            // 02. List of All Registered Users
                            // InkWell(
                            //   splashColor: Color.fromARGB(255, 5, 20, 68),
                            //   onTap: () { 
                            //     Get.to(() => ListOfAllUsersScreen(), transition: Transition.leftToRight);
                            //   },
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
                            //               backgroundColor: Color.fromARGB(255, 0, 115, 177),
                            //               child: Icon(
                            //                 Icons.store,
                            //                 color: Colors.white, 
                            //                 size: 35),
                            //             ),
                            //             SizedBox(width: 10),
                            //             Expanded(
                            //               child: Row(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text("List of user",
                            //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            //                 ],
                            //               ),
                            //             ),
                            //              SizedBox(width: 10),
                            //              IconButton(
                            //               onPressed: () {
                            //                 Get.to(() => ListOfAllUsersScreen(), transition: Transition.leftToRight);
                            //               }, 
                            //               icon: Icon(
                            //                 Icons.arrow_forward_ios, 
                            //                 color: Colors.black, 
                            //                 size: 30),
                            //               ),  
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   )
                            //   ),
                            // ),
                          ]
                        )
                    )
                )
            );
        }
    }