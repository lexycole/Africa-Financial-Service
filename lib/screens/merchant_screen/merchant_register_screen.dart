import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/merchant_screen/merchant_login_screen.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:im_stepper/stepper.dart';

class RegisterMerchantScreen extends StatefulWidget {
  const RegisterMerchantScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMerchantScreen> createState() => _RegisterMerchantScreenState();
}

class _RegisterMerchantScreenState extends State<RegisterMerchantScreen> {
  int activeIndex = 0;
  int totalIndex = 2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (activeIndex == 0) {
            return true;
          } else {
            setState(() {
              activeIndex--;
            });
            return false;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
              backgroundColor: AppColors.AppBannerColor,
              title: const Text('Merchant Registration'),
            ),
            body: bodyBuilder()));
  }

  Widget bodyBuilder() {
    switch (activeIndex) {
      case 0:
        return merchantDetailsOne();
      case 1:
        return merchantDetailsTwo();
      default:
        return merchantDetailsOne();
    }
  }

  // 01. Address, first name, last name, any ID
  Widget merchantDetailsOne() {
    var addressController = TextEditingController();
    var lastNameController = TextEditingController();
    var anyIdController = TextEditingController();
    var pictureController = TextEditingController();

    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Text(
                    'Register as Merchant',
                    style: TextStyle(
                        fontSize: Dimensions.font16 * 2,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Center(
                child: DotStepper(
                  activeStep: activeIndex,
                  dotRadius: 20.0,
                  shape: Shape.pipe,
                  spacing: 10.0,
                  indicatorDecoration: IndicatorDecoration(
                    color: AppColors.AppBannerColor,
                  ),
                ),
              ),
              Text(
                "Step ${activeIndex + 1} of $totalIndex",
                style: TextStyle(
                    fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimensions.height20),
              // Address
              AppTextField(
                hintText: 'Address',
                icon: Icons.add_location_outlined,
                textController: addressController,
              ),
              SizedBox(height: Dimensions.height20),
              AppTextField(
                hintText: 'Picture of Selected Id',
                icon: Icons.image,
                textController: pictureController,
              ),
              SizedBox(height: Dimensions.height20),
              AppTextField(
                hintText: 'Any Id',
                icon: Icons.perm_identity_outlined,
                textController: anyIdController,
              ),
              SizedBox(height: Dimensions.height20),
              // Last Name
              AppTextField(
                hintText: 'Last Name',
                icon: Icons.account_circle_outlined,
                textController: lastNameController,
              ),
              SizedBox(height: Dimensions.height20),              
              SizedBox(height: Dimensions.height20),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex++;
                    });
                  },
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
                              text: "Next",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white)))),
            ])));
  }

  // 02.Picture, Email, phone number, password
  Widget merchantDetailsTwo() {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimensions.screenHeight * 0.05),
          Center(
            child: DotStepper(
              activeStep: activeIndex,
              dotRadius: 20.0,
              shape: Shape.pipe,
              spacing: 10.0,
              indicatorDecoration: IndicatorDecoration(
                color: AppColors.AppBannerColor,
              ),
            ),
          ),
          Text(
            "Step ${activeIndex + 1} of $totalIndex",
            style: TextStyle(
                fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Dimensions.height20),
          // First Name
          AppTextField(
                hintText: 'First Name',
                icon: Icons.account_circle_outlined,
                textController: nameController,
              ),
          SizedBox(height: Dimensions.height20),
          // Email
          AppTextField(
            hintText: 'Email',
            icon: Icons.email,
            textController: emailController,
          ),
          SizedBox(height: Dimensions.height20),
          // Phone
          AppTextField(
            hintText: 'Phone Number',
            icon: Icons.phone,
            textController: phoneController,
          ),
          SizedBox(height: Dimensions.height20),
          // Password
          AppTextField(
            hintText: 'Password',
            icon: Icons.lock_outlined,
            textController: passwordController,
          ),
          SizedBox(height: Dimensions.height20),
          // Confirm Password
          AppTextField(
            hintText: 'Confirm Password',
            icon: Icons.lock_outlined,
            textController: confirmPasswordController,
          ),
          SizedBox(height: Dimensions.screenHeight * 0.05),
          // Merchant Sign In Button
          GestureDetector(
            child: Container(
                  width: Dimensions.screenWidth / 10 * 9,
                  height: Dimensions.screenHeight / 10,
                  decoration: BoxDecoration(
                    color: AppColors.AppBannerColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Center(
                      child: BigText(
                          text: "Register",
                          size: Dimensions.font20 + Dimensions.font20 / 2,
                          color: Colors.white)))),
          SizedBox(height: Dimensions.screenHeight * 0.05),
          RichText(
              text: TextSpan(
                  text: "A merchant already? ",
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimensions.font20),
                  children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Get.to(() => MerchantLoginScreen()),
                  text: ' Log in',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.AppBannerColor,
                      fontSize: Dimensions.font20),
                )
              ])),
          SizedBox(
            height: Dimensions.height10,
          ),
        ],
      ),
    ));
  }
}
