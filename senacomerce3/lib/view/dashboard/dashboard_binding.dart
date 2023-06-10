import 'package:get/get.dart';
import 'package:senacomerce3/controller/auth_controller.dart';
import 'package:senacomerce3/controller/category_controller.dart';
import 'package:senacomerce3/controller/dashboard_controller.dart';
import 'package:senacomerce3/controller/home_controller.dart';
import 'package:senacomerce3/controller/product_controller.dart';

class DashboardBinding2 extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(CategoryController());
    Get.put(AuthController());
  }
}