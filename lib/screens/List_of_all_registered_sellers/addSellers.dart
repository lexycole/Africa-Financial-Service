// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:xcrowme/apis/seller_api.dart';
// import 'package:xcrowme/models/seller.dart';

// class AddSellerScreen extends StatefulWidget {
//   @override
//   _AddSellerScreenState createState() => _AddSellerScreenState();
// }

// class _AddSellerScreenState extends State<AddSellerScreen> {
//   final sellerTitleController = TextEditingController();
//   final sellerDesController = TextEditingController();

//   void onAdd() {
//     final String textVal = sellerTitleController.text;
//     final String desVal = sellerDesController.text;

//     if (textVal.isNotEmpty && desVal.isNotEmpty) {
//       final Seller seller = Seller(title: textVal, description: desVal);
//       Provider.of<SellerProvider>(context, listen: false).addSeller(seller);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Seller')),
//       body: 
//       ListView(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         width:28,
//               child: Column(
//             children: [
//               SizedBox(height: 10,),
//               TextField(

//                 controller: sellerTitleController,
//               ),
//               SizedBox(height: 10,),
              
//               TextField(
//                 decoration: InputDecoration(),
//                 controller: sellerDesController,
//               ),
//               SizedBox(height: 10,),
//               ElevatedButton(
//                   child: Text('Add'),
//                   onPressed: () {
//                     onAdd();
//                     Navigator.of(context).pop();
//                   })
//               ],
//             )
//           )
//         ],
//       ),
//     );
//   }
// }


 // Container(
                  //   padding: EdgeInsets.only(left: 10.0),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [

                  //             Text('Default Percentage Cut',
                  //                 style: TextStyle(
                  //                     fontSize: Dimensions.font20,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black)),
                  //             SizedBox(
                  //               height: 5.0,
                  //             ),
                  //             Text('${210000000}'),
                  //             SizedBox(
                  //               height: 5.0,
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 20.0),
                  //         Row(
                  //           children: [
                  //             IconButton(
                  //               onPressed: () {},
                  //               icon: Icon(Icons.edit,
                  //                   color: AppColors.bgBtnColor),
                  //             ),
                  //             IconButton(
                  //               onPressed: () {},
                  //               icon: Icon(Icons.save,
                  //                   color: AppColors.bgBtnColor),
                  //             ),
                  //           ],
                  //         ),

                  //         //  GestureDetector(
                  //         //       onTap: (){
                  //         //         Clipboard.setData(ClipboardData(text: "210,000,000 btc"));
                  //         //       },
                  //         //       child: Container(
                  //         //       width: Dimensions.screenWidth/10*2,
                  //         //       height: 50.0,
                  //         //       decoration: BoxDecoration(
                  //         //         color: AppColors.bgBtnColor,
                  //         //         borderRadius: BorderRadius.circular(Dimensions.radius20),
                  //         //       ),
                  //         //       child: Center(
                  //         //         child: BigText(
                  //         //           text: "Copy",
                  //         //           size: Dimensions.font20+Dimensions.font20/2,
                  //         //           color: Colors.white
                  //         //         )
                  //         //       )
                  //         //     )
                  //         //   ),
                  //       ]),
                  // ),

                  // Container(
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Container(
                            //         width: 100,
                            //         height: 40,
                            //         child: ElevatedButton(
                            //           onPressed: () async {
                            //             Navigator.of(context)
                            //                 .pushAndRemoveUntil(
                            //                     MaterialPageRoute(
                            //                         builder: (context) =>
                            //                             SignInScreen()),
                            //                     (route) => false);
                            //           },
                            //           child: Text("Log Out"),
                            //           style: ElevatedButton.styleFrom(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(20.0),
                            //             ),
                            //             backgroundColor:
                            //                 Color.fromARGB(255, 255, 89, 89),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )