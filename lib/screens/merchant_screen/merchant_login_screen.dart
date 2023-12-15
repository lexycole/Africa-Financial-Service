import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:xcrowme/screens/verify-otp_screen/index.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';

class MerchantLoginScreen extends StatefulWidget {
  const MerchantLoginScreen({Key? key}) : super(key: key);

  @override
  State<MerchantLoginScreen> createState() => _MerchantLoginScreenState();
}

class _MerchantLoginScreenState extends State<MerchantLoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.AppBannerColor,
          title: const Text('Login as Merchant'),
        ),
        body: Center(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back, {nickname}',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ])),
                    SizedBox(height: Dimensions.height20),
                    // Email
                    AppTextField(
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        textController: emailController),
                    SizedBox(height: Dimensions.height20),
                    // Password
                    AppTextField(
                        hintText: 'Password',
                        icon: Icons.lock_outlined,
                        textController: passwordController),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    Row(children: [
                      SizedBox(
                        width: Dimensions.width20,
                      )
                    ]),
                    // Merchant Login Button
                    GestureDetector(
                        onTap: () => Get.to(VerifyOTPScreen(phoneNumber: '',)),
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
                                    text: "Login",
                                    size: Dimensions.font20 +
                                        Dimensions.font20 / 2,
                                    color: Colors.white)))),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    RichText(
                        text: TextSpan(
                            text: "Not a merchant ? ",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20),
                            children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.offNamed(
                                  RouteHelper.getMerchantRegisterScreen()),
                            text: ' Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.AppBannerColor,
                                fontSize: Dimensions.font20),
                          )
                        ])),
                  ],
                ))));
  }
}
