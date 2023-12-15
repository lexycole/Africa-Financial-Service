import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/base/show_failure_custom_message.dart';
import 'package:xcrowme/base/show_success_custom_message.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/update_sellers_detail_modal.dart';
import 'package:xcrowme/screens/List_of_all_registered_sellers/index.dart';
import 'package:xcrowme/screens/create_seller_screen/index.dart';
import 'package:xcrowme/screens/store_screen/addStore.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String initialValue;
  final String sellerId;

  const ProfileScreen({
    Key? key,
    required this.initialValue,
    required this.sellerId,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LoginController loginController =
      Get.find(); // Get the instance of LoginController

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  bool _isEditing = false;
  bool _isDoneVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSellerDetail(); // Call the function to fetch data on widget initialization
    _firstNameController = TextEditingController(text: widget.initialValue);
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      _isDoneVisible = _isEditing; // Update the visibility of the done button
    });
  }

  // Fetch Seller Detail
  Future<void> fetchSellerDetail() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': 'gi6paFHGatKXClIE',
      'Api-Sec-Key': 'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.sellerDetail
              .replaceFirst('{uid}', widget.sellerId));

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData =
            jsonDecode(response.body)['data'] as Map<String, dynamic>;
        String firstName = jsonData['first_name'];
        String lastName = jsonData['last_name'];
        String dob = jsonData['dob'];
        String phone = jsonData['phone'];
        // Use the fetched data as needed, e.g., display in the text field
        setState(() {
          _firstNameController.text = firstName;
          _lastNameController.text = lastName;
          _phoneController.text = phone;
          _dobController.text = dob;
          _isLoading = false;
        });
      } else if (response.statusCode == 400 && response.statusCode == 401) {
        setState(() {
          _isLoading = false;
        });
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading to false on error
      });
      // showFailureSnackBar('Error', title: e.toString());
    }
  }

// Update Seller Details
  Future<void> updateSellerDetails() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String phone = _phoneController.text;
    final String dob = _dobController.text;

    final Map<String, dynamic> body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'dob': dob,
    };

    try {
      final LoginController loginController = Get.find<LoginController>();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': 'gi6paFHGatKXClIE',
        'Api-Sec-Key':
            'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };
      final url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.updateSellerDetails
              .replaceFirst('{uid}', widget.sellerId));

      final http.Response response = await http.put(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Successful update
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UpdateSellerDetailModel updateSeller = UpdateSellerDetailModel(
          uid: responseData['data']['uid'],
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          dob: dob,
        );
        showSuccessSnackBar("Seller Updated! Successfully", title: "Perfect");
      }
    } catch (e) {
      e.toString();
      showFailureSnackBar('Error', title: e.toString());
    }
  }

// Delete Seller Details
  Future<void> deleteSellerDetails() async {
    try {
      final LoginController loginController = Get.find<LoginController>();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Api-Key': 'gi6paFHGatKXClIE',
        'Api-Sec-Key':
            'XpxuKn.5tL0HT1VeuFIjg8EDRznQ07xPs3TcKUx.vAEgQcOgGjPikbc2',
        'Authorization': 'Bearer ${loginController.accessToken.value}',
      };
      final url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.deleteSellerDetail
              .replaceFirst('{uid}', widget.sellerId));

      final http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 204) {
        // Successful deletion
        showSuccessSnackBar("Seller Deleted Successfully", title: "Deleted");
        // Navigate to ListOfAllSellersScreen
        Get.offAll(ListOfAllSellersScreen(
          newSellers: [],
        ));
      } else {
        // Handle the case when deletion fails
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      e.toString();
      showFailureSnackBar('Error', title: e.toString());
    }
  }

  Widget buildProfileView() {
    if (_isLoading) {
      // Display loading indicator
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_firstNameController.text.isNotEmpty) {
      // Display content when status code is 200
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 45),
              ),
              SizedBox(width: 10), // Add spacing between the avatar and text
              LayoutBuilder(
                builder: (context, constraints) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Percentage Cut',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: constraints.maxWidth < 200
                          ? 3
                          : 1, // Adjust the threshold as needed
                    ),
                  );
                },
              ),
              Spacer(), // Add space between the text and the edit button
              Row(
                children: [
                  IconButton(
                    onPressed: toggleEdit,
                    icon: Icon(Icons.edit, color: AppColors.bgBtnColor),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.save, color: AppColors.bgBtnColor),
                  ),
                ],
              ), // Add spacing between the edit button and other elements
            ],
          ),
          SizedBox(height: 20),
          if (_isEditing)
            Column(children: [
              GestureDetector(
                onTap: toggleEdit,
                child: TextField(
                  controller: _firstNameController,
                  enabled: _isEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _lastNameController,
                enabled: _isEditing,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                enabled: _isEditing,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dobController,
                enabled: _isEditing,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
            ]),

          // Not Editing
          if (!_isEditing)
            Column(
              children: [
                Card(
                  elevation: 2,
                  child: GestureDetector(
                    child: TextField(
                      controller: _firstNameController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove the border outline
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: TextField(
                    controller: _lastNameController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Remove the border outline
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: TextField(
                    controller: _phoneController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Remove the border outline
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: TextField(
                    enabled: false,
                    controller: _dobController,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Remove the border outline
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          Visibility(
            visible: _isDoneVisible,
            child: Container(
              width: double
                  .infinity, // Set the width to occupy the available space
              child: ElevatedButton(
                onPressed: () {
                  if (_isEditing) {
                    updateSellerDetails(); // Call the function to update the seller details
                  }
                },
                child: Text("Done"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.bgBtnColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 89, 89),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: deleteSellerDetails,
            child: Text(
              "Delete Seller account",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.bgBtnColor,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    } else {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        elevation: 4, // Add elevation for a raised effect
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.store),
              SizedBox(height: 10),
              Text("No seller profile created"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => CreateSellerScreen());
                    },
                    child: Row(
                      children: [
                        Text("Add"),
                        Icon(Icons.add), // Plus icon
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 25.0),
                padding: EdgeInsets.all(Dimensions.width20),
                child: Column(children: [
                  // Seller's Profile Widget
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Align contents to start and end
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: AppColors.AppBannerColor),
                                onPressed: () =>
                                    Get.offAll(BottomTab(initialIndex: 1)),
                              ),
                              Center(
                                child: Text(
                                  "Seller's Profile",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                    Icons.add_business, // Add your icon here
                                    color: AppColors.bgBtnColor,
                                    size: 36), // Customize the icon color
                                onPressed: () {
                                  Get.to(
                                      () => AddStoreScreen(
                                            sellerId: widget.sellerId,
                                          ),
                                      transition: Transition.rightToLeft);
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  // User Information
                  Padding(
                      padding: EdgeInsets.all(8.0), child: buildProfileView()),
                ]))));
  }
}
