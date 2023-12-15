import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/resend_otp.dart';
import 'package:xcrowme/controllers/withdraw_verify_otp_controller.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'dart:async';


class WithdrawVerifyOTP extends StatefulWidget {
  final String phoneNumber; 
  WithdrawVerifyOTP({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<WithdrawVerifyOTP> createState() => _WithdrawVerifyOTPState();
}

class _WithdrawVerifyOTPState extends State<WithdrawVerifyOTP> {  
  WithdrawVerifyOtpController verifyOtpController = Get.put(WithdrawVerifyOtpController());
  ResendOtpController resendOtpController = Get.put(ResendOtpController());
  
int _secondsRemaining = 120;
  bool _timerActive = false;

  void startTimer() {
    setState(() {
      _timerActive = true;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          _timerActive = false;
        });
      } else {         
        setState(() {
          _secondsRemaining--;
        });
        if (_secondsRemaining == 195) {
          resendOtpController.resendotp();
        }
      }
    });
  }

  String getFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Get.put(LoginController()); 
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String phoneNumber = verifyOtpController.phoneController.text;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 20, 68),
      body: SingleChildScrollView(
        child: Container(
            child: Column(children: <Widget>[
          SizedBox(
              height: size.height,
              child: Stack(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.1, left: 20, right: 20),
                  decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child:  Text(
                              "Enter One Time Password",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "We have sent the code verification the number you entered for registration eariler",
                            style: TextStyle(fontSize: 16, color: Color(0xFFB40284A)),
                          ),                        
                          SizedBox(height: 10),
                        if (_timerActive)
                          Text(
                            getFormattedTime(_secondsRemaining),
                            style: TextStyle(fontSize: 20,),
                          ),                       
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              controller: verifyOtpController.otpController,
                              decoration: InputDecoration(
                                hintText: 'OTP code',
                                prefixIcon: Icon(Icons.lock_outline_rounded,
                                    color: AppColors.textColor),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Color(0xFFBC7C7C7))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Color(0xFFBC7C7C7))),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                              )),
                          SizedBox(
                            height: 35,
                          ),
                            GestureDetector(
                                  onTap: () => verifyOtpController.verifyotp(),
                                  child: Container(
                                      width: Dimensions.screenWidth / 2,
                                      height: Dimensions.screenHeight / 9,
                                      decoration: BoxDecoration(
                                        color: AppColors.AppBannerColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                      ),
                                      child: Center(
                                          child: BigText(
                                              text: "Confirm",
                                              size: Dimensions.font20 +
                                                  Dimensions.font20 / 2,
                                              color: Colors.white)
                                              )
                                        )
                              ),
                              SizedBox(height: 30),
                              if (!_timerActive)
                              RichText(
                                  text: TextSpan(
                                      text: "Did not receive OTP",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: Dimensions.font20),
                                      children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap =
                                            () => startTimer(),
                                      text: ' Resend',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.AppBannerColor,
                                          fontSize: Dimensions.font20),
                                    )
                                  ]
                                )
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:  EdgeInsets.fromLTRB(10, 60, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Ink(
                          decoration:  ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon:  Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )),
              ]))
        ])),
      ),
    );
  }
}
