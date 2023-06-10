import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:senacomerce3/view/dashboard/dashboard_screen.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Lottie.asset('assets/food.json'), nextScreen: MyApp(),duration: 3000,backgroundColor: Colors.white,splashIconSize: 300,);
  }
}
