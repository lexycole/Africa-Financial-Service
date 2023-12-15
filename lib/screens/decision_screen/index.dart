import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcrowme/screens/home_screen/index.dart';
import 'package:xcrowme/screens/sign_in_screen/index.dart';

class DecisionScreen extends StatelessWidget {
  const DecisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final prefs = snapshot.data!;
          final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
          if (isLoggedIn) {
            return TokenExpirationChecker();
          } else {
            return SignInScreen();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}


class TokenExpirationChecker extends StatefulWidget {
  @override
  _TokenExpirationCheckerState createState() => _TokenExpirationCheckerState();
}

class _TokenExpirationCheckerState extends State<TokenExpirationChecker> {
  final int refreshTokenDuration = 5000; // Refresh token duration in milliseconds
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _checkTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    final int loginTime = prefs.getInt('loginTime') ?? 0;
    final int currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime - loginTime >= refreshTokenDuration) {
      // Token has expired, redirect to the login page
      prefs.setBool('isLoggedIn', false);
      Get.offAll(SignInScreen());
    } else {
      // Token is still valid, redirect to the home page
      Get.offAll(HomeScreen(newStores: [],));
    }
  }

  @override
  void initState() {
    super.initState();
    _checkTokenExpiration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}