import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:xcrowme/widgets/big_text.dart';



class WithdrawCompleteScreen extends StatefulWidget {
  const WithdrawCompleteScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawCompleteScreen> createState() => _WithdrawCompleteScreenState();
}

class _WithdrawCompleteScreenState extends State<WithdrawCompleteScreen> {
  final LoginController loginController =
      Get.find();

  List<Map<String, dynamic>> dropdownItems = [];
  Map<String, dynamic>? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
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
                        "Withdraw",
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
                                  'Withdraw',
                                  style: TextStyle(
                                      fontSize: Dimensions.font26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                      SizedBox(height: Dimensions.height20),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        width: double.infinity,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 10),
                                  color: Color.fromARGB(255, 162, 158, 158)
                                      .withOpacity(0.2))
                            ]),
                        child: DropdownButton<Map<String, dynamic>>(
                          value: selectedValue,
                          items: dropdownItems.map((item) {
                            String name = item['name'];
                            String code = item['code'];
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: item,
                              child: Text('$name ($code)'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          hint: Text('Select a bank'),
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                padding: EdgeInsets.all(10),
                child:  Center(
                  child: Image(
                      image: AssetImage("assets/checklist_good.png"),
                        )
                      )
                    ),
                      GestureDetector(
                          // onTap: () => Get.to(() => HomeScreen(newStores: [],))
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
                                      text: "Withdraw",
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
