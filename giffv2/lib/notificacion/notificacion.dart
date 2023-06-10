import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/gif_app.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  //Esta constante se encargara de la notificacion android
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('gif');
  //Esta constante se encargara de la notificacion IOS

  const DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings();
  //Se definen las variables para cada tipo de dispositivo

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotificacion(Gif gif) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
  );
  //Aqui veremos los detalles de la notificacion (id, titulo y contenido)

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
      1,
      'Visualizacion',
      'El usuario selecciono y visualizo el gif ${gif.name}.',
      notificationDetails);
}