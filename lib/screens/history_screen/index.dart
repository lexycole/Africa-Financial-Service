import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/List_of_all_registered_sellers/index.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
        body: SingleChildScrollView(
                child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(left:20, right:20),
                      margin: EdgeInsets.only(top: 55.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                            Container(
                              padding: const EdgeInsets.only(left:10.0, top:20.0, bottom:20.0), 
                              child: Text("History", style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold)),
                              ),
                            InkWell(
                              splashColor: Color.fromARGB(255, 5, 20, 68),
                              onTap: () {
                                Get.to(() => ListOfAllSellersScreen(newSellers:[], sellerId: '',), transition: Transition.leftToRight);
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
                                            backgroundColor: AppColors.AppBannerColor,
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
                                                Text("Recent Sellers",
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                            SizedBox(width: 10),
                                          IconButton(
                                            onPressed: () {
                                              Get.to(() => ListOfAllSellersScreen( newSellers: [], sellerId: '',),);
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
                          ]
                        )
                    )
                )
            ) 
          );
        }
    }