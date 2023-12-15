import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:xcrowme/widgets/password_text_field.dart';
import 'package:xcrowme/widgets/phone_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginController loginController = Get.put(LoginController());
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    child: Center(
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      backgroundImage: AssetImage(
                        "assets/ic_foreground_img.png",
                      )),
                )),
                Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    width: double.maxFinite,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Sign into your account',
                            style: TextStyle(
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                SizedBox(height: Dimensions.height20),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0,),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'ng.png',
                            width: 50,
                            height: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '+234',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: PhoneTextField(
                          textController: loginController.phoneController,
                          hintText: '8xx xxxx xxx',
                          icon: Icons.phone,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height20),
                // Password
                PasswordTextField(
                  hintText: ' Enter Password',
                  icon: Icons.lock_outline_rounded,
                  textController: loginController.passwordController,
                  isPassword: true,
                ),
                SizedBox(height: Dimensions.height20),
                // Sign In to your account
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RichText(
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Get.offNamed(RouteHelper.getSignUpScreen()),
                              text: 'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.AppBannerColor,
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight * 0.05),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: GestureDetector(
                    onTap: () => loginController?.loginWithEmail(),
                    child: Container(
                      width: Dimensions.screenWidth / 10 * 8,
                      height: Dimensions.screenHeight / 10,
                      decoration: BoxDecoration(
                        color: AppColors.AppBannerColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign In",
                          size: Dimensions.font20 + Dimensions.font20 / 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight * 0.02),
                RichText(
                    text: TextSpan(
                        text: "Not a member of cashrole? ",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20),
                        children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Get.offNamed(RouteHelper.getSignUpScreen()),
                        text: ' Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.AppBannerColor,
                            fontSize: Dimensions.font20),
                      )
                    ])),
                SizedBox(
                  height: Dimensions.height20,
                ),
              ],
            )));
  }
}
