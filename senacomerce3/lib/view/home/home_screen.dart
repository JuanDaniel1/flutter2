import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/component/main_header.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/view/home/components/popular_category/popular_category.dart';
import 'package:senacomerce3/view/home/components/popular_product/popular_product.dart';
import 'package:senacomerce3/view/home/components/popular_product/popular_product_loading.dart';
import 'package:senacomerce3/view/home/components/section_title.dart';

import '../../model/product.dart';
import 'components/carousel_slider/carousel_slider_view.dart';
import 'components/popular_category/popular_category_loading.dart';
import 'components/carousel_slider/carousel_loading.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            MainHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Obx(() {
                      if (homeController.bannerList.isNotEmpty) {
                        return CarouselSliderView(
                            bannerList: homeController.bannerList);
                      } else {
                        return const CarouselLoading();
                      }
                    }),
                    const SectionTitle(title: "Categoria Popular"),
                    Obx(() {
                      if (homeController.popularCategoryList.isNotEmpty) {
                        return PopularCategory(
                            categories: homeController.popularCategoryList);
                      } else {
                        return const PopularCategoryLoading();
                      }
                    }),
                    const SectionTitle(title: "Producto Popular"),
                    Obx(() {
                      if (homeController.popularProductList.isNotEmpty) {
                        return PopularProduct(
                            popularProducts: homeController.popularProductList);
                      } else {
                        return const PopularProductLoading();
                      }
                    }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}