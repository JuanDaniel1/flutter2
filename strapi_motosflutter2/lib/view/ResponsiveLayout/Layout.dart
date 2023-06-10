import 'package:flutter/material.dart';
import 'package:strapi_motosflutter/view/ResponsiveLayout/movil.dart';
import 'package:strapi_motosflutter/view/ResponsiveLayout/tablet.dart';

import 'Desktop.dart';
class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  final Map<String, String> dataHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  @override

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Movil();
        } else if (constraints.maxWidth < 1100) {
          return tablet();
        } else {
          return Desktop();
        }
      },
    );
  }
}


//Llamamos a estas variables que se van a definir dependiendo del ancho de la ventana
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Movil();
        } else if (constraints.maxWidth < 1100) {
          return tablet();
        } else {
          return Desktop();
        }
      },
    );
  }
