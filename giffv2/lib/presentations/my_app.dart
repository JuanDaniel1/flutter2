import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:giffv2/models/gif_app.dart';
import 'dart:convert';
import 'package:giffv2/ResponsiveLayout/desktop_body.dart';
import 'package:giffv2/ResponsiveLayout/mobil_body.dart';
import 'package:giffv2/ResponsiveLayout/tablet_body.dart';
import 'package:giffv2/ResponsiveLayout/responsive_layout.dart';
import 'package:giffv2/notificacion/notificacion.dart';
import 'package:lottie/lottie.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Lottie.asset('images/Loading.json'), nextScreen: ResponsiveLayout(),duration: 3000,backgroundColor: Colors.deepOrange,splashIconSize: 300,);
  }
}
//En este caso creamos variables que son definidas por las clases de mobil, escritorio y tablet
