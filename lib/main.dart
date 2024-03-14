import 'package:flutter/material.dart';
import 'package:xcrowme/auth/auth_middleware.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:xcrowme/screens/splash_screen/index.dart';

void main() async {
  final LoginController loginController = Get.put(LoginController());
    Get.lazyPut(() => LoginController()); 
    Get.put(AuthMiddleware());
  runApp(
  GetMaterialApp(
      home:  SplashScreen(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
      debugShowCheckedModeBanner : false
      )
  );
}

