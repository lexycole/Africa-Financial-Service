import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/registration_controller.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:xcrowme/widgets/password_text_field.dart';
import 'package:xcrowme/widgets/phone_input.dart';
import 'package:intl/intl.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController());
      

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
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize:
                                Dimensions.font16 * 3 + Dimensions.font16 / 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
            SizedBox(height: Dimensions.height15),
            AppTextField(
              hintText: 'Your First Name',
              icon: Icons.account_circle_outlined,
              textController: registrationController.firstnameController,
            ),
            SizedBox(height: Dimensions.height20),
           
            AppTextField(
              hintText: 'Your Last Name',
              icon: Icons.account_circle_outlined,
              textController: registrationController.lastnameController,
            ),
            SizedBox(height: Dimensions.height20),
          
            AppTextField(
              hintText: 'your@gmail.com',
              icon: Icons.email_outlined,
              textController: registrationController.emailController,
            ),
            SizedBox(height: Dimensions.height20),
            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                boxShadow: [
                  BoxShadow (
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: Offset(1, 10),
                    color: Colors.grey.withOpacity(0.2)
                  )
                ]
              ),
              child: TextField(
                  controller:  registrationController.dobController,
                  decoration: InputDecoration(
                      hintText: 'Enter Date',
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color:AppColors.textColor
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey
                          )
                      ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white
                          ) 
                      ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                      ),
                  ),
                  readOnly: true,
                  onTap: () async{
                    DateTime? pickedDate=await showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    );
                    if(pickedDate!=null){
                      String formattedDate=DateFormat("yyyy-MM-dd").format(pickedDate);
                        setState(() {
                            registrationController.dobController.text=formattedDate.toString();
                        });
                    }else{
                      print("Not selected");
                    }
                  },
                ),
            ),
            SizedBox(height: Dimensions.height20),
            PasswordTextField(
              hintText: 'Your Password',
              icon: Icons.lock_outline_rounded,
              textController: registrationController.passwordController,
              isPassword: true,
            ),
            SizedBox(height: Dimensions.height20),
            PasswordTextField(
              hintText: 'Confirm Password',
              icon: Icons.lock_outline_rounded,
              textController: registrationController.password2Controller,
              isPassword: true,
            ),
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
                        textController: registrationController.phoneController,
                        hintText: '8xx xxxx xxx',
                        icon: Icons.phone,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16), 
              child: ElevatedButton(
                onPressed: () {
                  registrationController.register();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.AppBannerColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                ),
                child: Container(
                  width: Dimensions.screenWidth / 10 * 8,
                  height: Dimensions.screenHeight / 10,
                  child: Center(
                    child: BigText(
                      text: "Sign up",
                      size: Dimensions.font20 + Dimensions.font20 / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => Get.offNamed(RouteHelper.getSignInScreen()),
                    text: "A member of cashrole already? Log in",
                    style: TextStyle(
                        color: AppColors.AppBannerColor,
                        fontSize: Dimensions.font20))),
            SizedBox(
              height: Dimensions.height10,
            ),
          ],
        ),
      ),
    );
  }
}
