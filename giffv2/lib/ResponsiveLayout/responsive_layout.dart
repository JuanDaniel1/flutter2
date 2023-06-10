import 'package:flutter/material.dart';
import 'package:giffv2/ResponsiveLayout/desktop_body.dart';
import 'package:giffv2/ResponsiveLayout/mobil_body.dart';
import 'package:giffv2/ResponsiveLayout/tablet_body.dart';

class ResponsiveLayout extends StatelessWidget {


  const ResponsiveLayout({
    super.key,

});
//Llamamos a estas variables que se van a definir dependiendo del ancho de la ventana
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return MobileScaffold();
        } else if (constraints.maxWidth < 1100) {
          return TabletScaffold();
        } else {
          return DesktopScaffold();
        }
      },
    );
  }
}