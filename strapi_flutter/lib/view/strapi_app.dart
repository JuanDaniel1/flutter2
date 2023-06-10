
import 'package:flutter/material.dart';
import 'package:strapi_flutter/view/add_user.dart';

class Strapi extends StatelessWidget {
  const Strapi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateUser(),
    );
  }
}
