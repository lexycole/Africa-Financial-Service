import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/models/store_list_modal.dart';
import 'package:xcrowme/models/store_modal.dart';
import 'package:xcrowme/screens/store_profile/store_profile.dart';
import 'package:xcrowme/screens/store_screen/addStore.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/api_endpoints.dart';
import 'package:xcrowme/utils/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/auth/auth_middleware.dart';


class StoreScreen extends StatefulWidget {
  final List<StoreModel> newStores;
  const StoreScreen({Key? key, required this.newStores}) : super(key: key);
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final LoginController loginController = Get.find();
  List<StoreListModel> listStores = [];
  bool isLoading = false; 
  @override
  void initState() {
    super.initState();
    fetchStoresList();
  }

  Future<void> fetchStoresList() async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Api-Key': '',
      'Api-Sec-Key': '',
      'Authorization': 'Bearer ${loginController.accessToken.value}',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.storesList);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData =
            jsonDecode(response.body)['data']['results'] as List<dynamic>;
        List<StoreListModel> fetchedStoresList = jsonData.map((item) {
          return StoreListModel(
            uid: item['uid'] ?? '',
            name: item['name'] ?? '',
            phone: item['phone'] ?? '',
            link: item['link'] ?? '',
          );
        }).toList();

        setState(() {
          if (widget.newStores.isNotEmpty) {
            List<StoreListModel> newStoresList = widget.newStores.map((store) {
              return StoreListModel(
                uid: '',
                phone: store.phone,
                name: store.name,
                link: store.link,
              );
            }).toList();
            listStores = [...newStoresList, ...fetchedStoresList];
          } else {
            listStores = fetchedStoresList;
          }
          isLoading = false; 
        });
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.offAll(BottomTab( initialIndex: 1));
          },
        ),
        backgroundColor: AppColors.AppBannerColor,
        title: const Text('Stores'),
      ),
      body: isLoading
        ? Center(
            child: CircularProgressIndicator(color: AppColors.AppBannerColor),
          )
        : listStores.isEmpty
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.store),
                      SizedBox(height: 10),
                      Text("No recent stores created"),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => AddStoreScreen(sellerId: ''));
                            },
                            child: Row(
                              children: [
                                Text("Create"),
                                Icon(Icons.add),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.AppBannerColor,
                          child:
                              Icon(Icons.store, color: Colors.white, size: 35),
                        )),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Your stores",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: constraints.maxHeight,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: listStores.length,
                                        itemBuilder: (context, index) {
                                          final store = listStores[index];
                                          return Card(
                                            child: ListTile(
                                              title: Container(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text('${store.name}',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          Text('${store.link}'),
                                                          Text('${store.phone}',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 26),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:BorderRadius .circular(10),
                                                        border: Border.all(
                                                            color: Colors.grey[400]!,
                                                            width: 1),
                                                      ),
                                                      child: Icon(
                                                          Icons.arrow_forward),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              leading: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:BorderRadius.circular(8),
                                                  color: Colors.grey[300],
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Icon(Icons.store_outlined,
                                                  size: 35,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onTap: () {
                                                Get.to(() => StoreProfileScreen(sellerId: '',  link: store.link, initialValue: '',),                                                
                                                  transition: Transition.rightToLeft,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      )
    );
  }
}
