import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class TransferSuccessfulScreen extends StatefulWidget {
  const TransferSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<TransferSuccessfulScreen> createState() => _TransferSuccessfulScreenState();
}

class _TransferSuccessfulScreenState extends State<TransferSuccessfulScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Center(
                child: Image(
                image: AssetImage("assets/checklist_good.png"),
            ))),
        SizedBox(height: Dimensions.height10),  
        Container(
            margin: EdgeInsets.only(left: Dimensions.width20),
            width: double.maxFinite,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Fund Sent',
                    style: TextStyle(
                        fontSize: Dimensions.font26,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Money sent to the account you provided',
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                ])),
      ],
  ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Dimensions.height15),
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.AppBannerColor,
            fixedSize: Size(
                Dimensions.screenWidth / 10 * 9, Dimensions.screenHeight / 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
          ),
          child: BigText(
            text: "Done",
            size: Dimensions.font20 + Dimensions.font20 / 2,
            color: Colors.white,
          ),
        ),
      ),
      )
    );
  }
}
