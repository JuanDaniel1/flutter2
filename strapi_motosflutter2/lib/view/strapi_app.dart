
import 'package:flutter/material.dart';
import 'package:strapi_motosflutter/view/ResponsiveLayout/Layout.dart';
import 'package:strapi_motosflutter/view/add_user.dart';
import 'package:strapi_motosflutter/view/show_users.dart';

import 'MyApp.dart';

class Strapi extends StatelessWidget {
  const Strapi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    );
  }
}
