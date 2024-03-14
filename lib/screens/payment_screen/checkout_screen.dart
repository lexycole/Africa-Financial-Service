import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';


class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          backgroundColor: AppColors.AppBannerColor,
          title:  Text('Checkout'),
        ),
        body: Container(
                width: double.maxFinite,
                margin:  EdgeInsets.only(top: 15.0),
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Column(
                        children: [
                        Text("Payment Method",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.0),
                        Text("Select how you want to pay",
                            style: TextStyle(fontSize: 21)),
                      ]
                    )
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center( 
                          child: Text(
                            "Bank Transfer",
                            textAlign: TextAlign.center, 
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),  
                      SizedBox(height: 25.0),                       
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical:20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              infoRow("Bank Name:", "United Bank For Africa"),
                              SizedBox(height: 5.0),
                              infoRow("Account Name:", "Timothy Solomon"),
                              SizedBox(height: 5.0),
                              infoRow("Account Number:", "9019728162"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                thickness: 5,
                                endIndent: 10,   ),
                            ),
                            Text("or"),
                            Expanded(
                              child: Divider(
                                thickness: 5,
                                indent: 10,    ),
                            ),
                          ],
                            ),
                             SizedBox(height: 10.0),
                    InkWell(
                    splashColor: Color.fromARGB(255, 5, 20, 68),
                    onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "ARxGiLKkPoz10wnwCt6kzayCiqdyZXU_03Fkis9bs4vtw6t2LKdN8DkXQn5OrbMxnnUDM7005DxEMQMv",
                secretKey: "EO8yj5Jp96BD3sP-l2ZrS0d4fvPSXhLggDn5YWjRP701EHHwuLjovsB6ZXR_7BEVtNDJnmOP6bV_qeuX",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: const [
                  {
                    "amount": {
                      "total": '1.99',
                      "currency": "USD",
                      "details": {
                        "subtotal": '1.99',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },  
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
                    child: Card(
                        margin:  EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:  EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.AppBannerColor,
                                    child: Icon(Icons.payments,
                                        color: Colors.white, size: 35),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Paystack",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 30),
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                ]
            )
          )
      )
    );
  }
}


Widget infoRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: Text(title,
          style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold)),
      ),
      Expanded(
        flex: 2,
        child: Text(value,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 18)),
      ),
    ],
  );
}