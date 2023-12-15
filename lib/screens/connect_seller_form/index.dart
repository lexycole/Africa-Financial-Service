import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/verify-otp_screen/index.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';

class ConnectSellerFormScreen extends StatelessWidget {
  const ConnectSellerFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneNumberController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.width20),
              width: Dimensions.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: AppColors.AppBannerColor),
                    onPressed: () => Get.offAll(BottomTab(initialIndex: 1)),
                  ),
                  SizedBox(width: Dimensions.width15),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Connect Seller",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Create Seller container
                      Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          width: double.maxFinite,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Connect Existing Seller',
                                  style: TextStyle(
                                      fontSize: Dimensions.font26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                      SizedBox(height: Dimensions.height20),
                      // Phone Number Field
                      AppTextField(
                        hintText: 'Phone Number',
                        icon: Icons.phone_outlined,
                        textController: phoneNumberController,
                      ),
                      SizedBox(height: Dimensions.height20),
                      // Connect Seller Button
                      GestureDetector(
                          onTap: () => Get.to(() => VerifyOTPScreen(phoneNumber: '',)),
                          child: Container(
                              width: Dimensions.screenWidth / 10 * 9,
                              height: Dimensions.screenHeight / 10,
                              decoration: BoxDecoration(
                                color: AppColors.AppBannerColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                  child: BigText(
                                      text: "Connect",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white)))),
                      SizedBox(height: Dimensions.screenHeight * 0.05)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
