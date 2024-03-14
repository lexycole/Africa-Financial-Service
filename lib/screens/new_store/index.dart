

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/store_profile/store_profile.dart';
import 'package:xcrowme/screens/store_screen/addStore.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class NewStoreScreen extends StatefulWidget {
  final String sellerId;
  const NewStoreScreen({Key? key,required this.sellerId,}) : super(key: key);

  @override
  State<NewStoreScreen> createState() => _NewStoreScreenState();
}

class _NewStoreScreenState extends State<NewStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.to(() => BottomTab(),
                transition: Transition.leftToRightWithFade),
          ),
          backgroundColor: AppColors.AppBannerColor,
          title: const Text('New store'),
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddStoreScreen(
                                      sellerId: widget.sellerId,                                      
                                    )
                                  ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.AppBannerColor, width: 3),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Icon(Icons.add_business,
                                          color: AppColors.AppBannerColor,
                                          size: 40),
                                      SizedBox(height: Dimensions.height10),
                                      Text('Add store',
                                          style: TextStyle(
                                            color: AppColors.AppBannerColor,
                                            fontSize: 18,
                                            overflow: TextOverflow.visible,
                                          ))
                                    ])
                                  ])),
                        )),
                    SizedBox(height: Dimensions.screenHeight * 0.02),
                  ],
                ),

        
                Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                  
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const StoreProfileScreen(initialValue: '', link: '', sellerId: '',)),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.AppBannerColor, width: 3),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Icon(Icons.list_alt,
                                          color: AppColors.AppBannerColor,
                                          size: 40),
                                      SizedBox(height: Dimensions.height10),
                                      Text('List of store',
                                          style: TextStyle(
                                            color: AppColors.AppBannerColor,
                                            fontSize: 18,
                                            overflow: TextOverflow.visible,
                                          ))
                                    ])
                                  ])),
                        )),
                    SizedBox(height: Dimensions.screenHeight * 0.02),
                  ],
                )
              ],
              )
            )
    ));
  }
}

