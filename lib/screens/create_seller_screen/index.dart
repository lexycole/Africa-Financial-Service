import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/sellers_modal.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/app_text_field.dart';
import 'package:xcrowme/widgets/big_text.dart';
import 'package:xcrowme/screens/profile_screen/index.dart';
import 'package:xcrowme/widgets/phone_input.dart';
import 'package:intl/intl.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


void main() {
  runApp(CreateSellerScreen());
}

class CreateSellerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateSellerApp(),
    );
  }
}

class CreateSellerApp extends StatefulWidget {

  @override
  _CreateSellerAppState createState() => _CreateSellerAppState();
}

class _CreateSellerAppState extends State<CreateSellerApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();


  DateTime? selectedDate;

  Future<void> _createSeller() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String phone = '+234${_phoneController.text}';
    final String dob = _dobController.text;

    final Map<String, dynamic> body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'dob': dob,
    };

    try {
      final LoginController loginController = Get.find<LoginController>();

      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createSeller);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': '',
        'Api-Sec-Key': '',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };

      final http.Response response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String sellerId = responseData['data']['uid'];

        final SellerModel seller = SellerModel(
          uid: responseData['data']['uid'],
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          dob: dob,
          sellerId: sellerId,
        );
        Get.to( () => ProfileScreen(
          initialValue: '',
          sellerId: seller.uid),
            transition: Transition.rightToLeft);
        showSuccessSnackBar("Seller Created Successfully", title: "Perfect");
      } else {
        throw jsonDecode(response.body)['data']['first_name'] ??
              jsonDecode(response.body)['data']['last_name'] ??
              jsonDecode(response.body)['data']['phone'] ??
              jsonDecode(response.body)['data']['dob'];
      }
    } catch (e) {
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime:Duration(minutes: 3),
      onIdle: () {
        showTimerDialog(1140000);
      }, 
      child: Scaffold(
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Create Seller",
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
                        Container(
                            margin: EdgeInsets.only(left: Dimensions.width20),
                            width: double.maxFinite,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create a new seller',
                                    style: TextStyle(
                                        fontSize: Dimensions.font26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                        SizedBox(height: Dimensions.height20),
                        Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextField(
                                      hintText: 'First Name',
                                      icon: Icons.account_circle_outlined,
                                      textController: _firstNameController,
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    AppTextField(
                                      hintText: 'Last Name',
                                      icon: Icons.account_circle_outlined,
                                      textController: _lastNameController,
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
                                          controller: _dobController,
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
                                                  _dobController.text=formattedDate.toString();
                                                });
                                            }else{
                                              print("Not selected");
                                            }
                                          },
                                        ),
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
                                              textController: _phoneController,
                                              hintText: '8xx xxxx xxx',
                                              icon: Icons.phone,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.height30),
                                    Center(
                                      child: GestureDetector(
                                        onTap: _createSeller,
                                        child: Container(
                                          width: Dimensions.screenWidth / 10 * 9,
                                          height: Dimensions.screenHeight / 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.AppBannerColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                          ),
                                          child: Center(
                                            child: BigText(
                                              text: "Create Seller",
                                              size: Dimensions.font20 +
                                                  Dimensions.font20 / 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: Dimensions.screenHeight * 0.05),
                                  ],
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
