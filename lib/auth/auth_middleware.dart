import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/controllers/login_controller.dart';
import 'package:xcrowme/controllers/refresh_token_controller.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'dart:async';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:xcrowme/screens/sign_in_screen/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_count_timer/easy_count_timer.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated = Get.find<LoginController>().isAuthenticated();
    if (!isAuthenticated) {
      return RouteSettings(name: RouteHelper.getSignInScreen());
    }
    return null;
  }
}

class IdleAuthMiddleware extends GetMiddleware {
  late LoginController loginController;
  
  @override
  RouteSettings? redirect(String? route) {
    loginController = Get.find<LoginController>();
    bool isAuthenticated = Get.find<LoginController>().isAuthenticated();
    if (!isAuthenticated) {
      return RouteSettings(name: RouteHelper.getSignInScreen());
    }
    return null;
  }

  @override
  Widget onPageBuilt(Widget page) {
    return IdleDetector(
      idleTime: const Duration(minutes: 1),
      onIdle: () {
        if (loginController.tokenFetchTime != null) {
          DateTime currentTime = DateTime.now();
          Duration timeSinceFetch = currentTime.difference(loginController.tokenFetchTime!);
          // Calculate the time until expiration (20 minutes)
          int secondsUntilExpiration = (20 * 60) - timeSinceFetch.inSeconds;
          print('Seconds Until Expiration: $secondsUntilExpiration');
          // Handle idle time as needed, for example, show a timer dialog
          showTimerDialog(secondsUntilExpiration);
        }
      },
      child: page,
    );
  }
}

void showTimerDialog(int secondsUntilExpiration) {
  RefreshTokenController refreshTokenController = RefreshTokenController();

  showDialog(
    context: Get.overlayContext ?? Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      int remainingSeconds = secondsUntilExpiration;

              return AlertDialog(
                title: Text('Your session will expire in:'),
                content:  ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child:Container(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CountTimer(
                          format: CountTimerFormat.minutesSeconds,
                          controller:CountTimerController(
                            endTime: DateTime.now().add(
                              Duration( 
                                minutes: 01,
                                seconds: 00,
                              ),
                            ),
                          ),
                          onEnd: () async {
                            await clearAccessToken();
                            Get.to(() => SignInScreen());
                          },
                        ),   
                      ],
                    ),
                  ),
                ),
              ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await clearAccessToken();
                      Get.to(() => SignInScreen());
                    },
                    child:  Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 89, 89),
                  ))),
                  TextButton(
                    onPressed: () async {
                      await refreshTokenController.refreshToken();
                      Navigator.of(context).pop();
                    },
                    child: Text("I'm still here"),
                  ),
                ],
              );
    },
  );
}

Future<void> clearAccessToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('tokens');
  await prefs.remove('refresh_token');
  print('remove token');
  final loginController = Get.find<LoginController>();
  if (loginController != null) {
    if (loginController.accessToken != null) {
      loginController.accessToken.value = '';
    }
  }
}