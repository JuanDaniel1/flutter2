import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:strapi_motosflutter/view/show_users.dart';

import 'ResponsiveLayout/Layout.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Lottie.asset('images/moto.json'), nextScreen: ResponsiveLayout(),duration: 3000,backgroundColor: Colors.white,splashIconSize: 300,);
  }
}
