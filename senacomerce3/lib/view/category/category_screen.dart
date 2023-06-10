import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/view/category/components/category_card.dart';

class CategoryScreen2 extends StatelessWidget {
  const CategoryScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.categoryList.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) =>
              CategoryCard2(category: categoryController.categoryList[index]),
        );
      } else {
        return Container();
      }
    });
  }
}