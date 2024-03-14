import 'package:flutter/material.dart';
import 'package:xcrowme/routes/route_helpers.dart';
import 'package:get/get.dart';
import 'package:xcrowme/utils/colors.dart';

void main() => runApp(const SplashScreen());

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreenWidget(),
    );
  }
}

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Get.offNamed(RouteHelper.getOnboardingScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          color: AppColors.AppBannerColor,
          child: FadeTransition(
            opacity: _animation,
            child: Padding(
                padding: EdgeInsets.all(10),
                child:   
                Center(child:
                Image(
                  image: AssetImage("assets/splashscreen.png"),
                )
            )
                ),
          ),
        )); 
  }
}
