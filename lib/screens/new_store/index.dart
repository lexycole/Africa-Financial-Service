// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import '../../apis/create.dart';
// import '../../apis/note.dart';

// class NewStoreScreen extends StatefulWidget {
//   const NewStoreScreen({Key? key}) : super(key: key);

//   @override
//   State<NewStoreScreen> createState() => _NewStoreScreenState();
// }

// class _NewStoreScreenState extends State<NewStoreScreen> {
//   Client client = http.Client();
//   List<Note> notes = [];

//  @override
//  void initState() {
//   _retrieveNotes();
//   super.initState();
//  }

// //  Retrieve Notes
//   _retrieveNotes() async {
//     notes = [];

//     List response = json.decode((await client.get(retrieveUrl)).body);
//     response.forEach((element) {
//       notes.add(Note.fromMap(element));
//     });
//     setState(() {

//     });
//   }

// // Add Note
//  void _addNote() {}

// // Delete Note
//  void _deleteNote(int id) {
//   client.delete(deleteUrl(id));
//   _retrieveNotes();
//  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//       onRefresh: () async {
//         _retrieveNotes();
//        },
//       child: ListView.builder(
//         itemCount: notes.hashCode,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(notes[index].note),
//             onTap:() {

//             },
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () =>  _deleteNote(notes[index].id),
//               )
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () =>
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePage(client:client))),
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/screens/store_profile/store_profile.dart';
import 'package:xcrowme/screens/store_screen/addStore.dart';
import 'package:xcrowme/tabs/bottom_tabs.dart';
import 'package:xcrowme/utils/colors.dart';
import 'package:xcrowme/utils/dimensions.dart';

class NewStoreScreen extends StatelessWidget {
  const NewStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.to(() => BottomTab(),
                transition: Transition.leftToRightWithFade),
          ),
          backgroundColor: AppColors.AppBannerColor,
          title: const Text('New store'),
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Column
                Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    // Create User Container
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddStoreScreen(
                                      sellerId: '',
                                    )),
                            // builder: (context) => AddStoreScreen()),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.AppBannerColor, width: 3),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Icon(Icons.add_business,
                                          color: AppColors.AppBannerColor,
                                          size: 40),
                                      SizedBox(height: Dimensions.height10),
                                      Text('Add store',
                                          style: TextStyle(
                                            color: AppColors.AppBannerColor,
                                            fontSize: 18,
                                            overflow: TextOverflow.visible,
                                          ))
                                    ])
                                  ])),
                        )),
                    SizedBox(height: Dimensions.screenHeight * 0.02),
                  ],
                ),

                // 02. Second Column
                Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    // Create User Container
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const StoreProfileScreen(initialValue: '', link: '', sellerId: '',)),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.AppBannerColor, width: 3),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Icon(Icons.list_alt,
                                          color: AppColors.AppBannerColor,
                                          size: 40),
                                      SizedBox(height: Dimensions.height10),
                                      Text('List of store',
                                          style: TextStyle(
                                            color: AppColors.AppBannerColor,
                                            fontSize: 18,
                                            overflow: TextOverflow.visible,
                                          ))
                                    ])
                                  ])),
                        )),
                    SizedBox(height: Dimensions.screenHeight * 0.02),
                  ],
                )
              ],
            )));
  }
}
