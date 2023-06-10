import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/component/main_header.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/view/product/components/product_grid.dart';
import 'package:senacomerce3/view/product/components/product_loading_grid.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          MainHeader(),

          Expanded(
              child: Obx((){
                if(productController.isProductLoading.value){
                  return const ProductLoadingGrid();
                } else {
                  if(productController.productList.isNotEmpty){
                    return ProductGrid(products: productController.productList);
                  } else {
                    return SingleChildScrollView(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/product_not_found.png'),
                            const SizedBox(height: 10),
                            const Text('Ups Producto No Encontrado!')
                          ],
                        ),
                    );

                  }
                }
              })
          ),

        ],
      ),
    );
  }
}