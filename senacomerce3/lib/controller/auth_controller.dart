import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/service/local_service/local_auth_service.dart';
import 'package:senacomerce3/service/remote_service/remote_auth_service.dart';
import 'package:senacomerce3/view/home/home_screen.dart';
import 'package:senacomerce3/view2/home/home_screen.dart';
import 'package:senacomerce3/view2/dashboard/dashboard_screen.dart';
import 'package:senacomerce3/view/dashboard/dashboard_screen.dart';

import '../model/product.dart';
import '../model/user.dart';
import '../view/pantallainicio.dart';

class AuthController extends GetxController {

  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    await _localAuthService.init();
    super.onInit();
  }

  void signUp({required String fullName, required String email, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signUp(
          email: email,
          password: password,
      );
      if(result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService().createProfile(fullName: fullName, token: token);
        if(userResult.statusCode == 200) {
          user.value = userFromJson(userResult.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);
          EasyLoading.showSuccess( "Bienvenido! "+ (authController.user.value?.fullName).toString());
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Something wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Something wrong. Try again!');
      }
    } catch(e){
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signIn(
        email: email,
        password: password,
      );
      if(result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService().getProfile(token: token);
        if(userResult.statusCode == 200) {
          user.value = userFromJson(userResult.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);
          EasyLoading.showSuccess("Bienvenido! "+ (authController.user.value?.fullName).toString());
          if(email == "admin@gmail.com" && password == "Admin1@"){
            Navigator.push(Get.overlayContext!, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen2()));

          }
          else{
            Navigator.of(Get.overlayContext!).pop();
          }

        } else {
          EasyLoading.showError('Something wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Username/password wrong');
      }
    } catch(e){
      debugPrint(e.toString());
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut() async {
    user.value = null;
    await _localAuthService.clear();
    Navigator.push(Get.overlayContext!, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen()));
  }
}