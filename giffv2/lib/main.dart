import 'package:flutter/material.dart';
import 'package:giffv2/notificacion/notificacion.dart';
import 'presentations/my_app.dart';
import 'models/gif_app.dart';

void main() async{
//Corremos esta funcion para que tome en cuenta la funcion de notificaciones primero para que se ejecute correctamente
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}


