import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/component/main_header.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/view2/CRUD/create.dart';
import 'package:senacomerce3/view2/product/components/product_grid.dart';
import 'package:senacomerce3/view2/product/components/product_loading_grid.dart';

import 'components/product_grid.dart';
import 'components/product_loading_grid.dart';

class ProductScreen2 extends StatefulWidget {
  const ProductScreen2({Key? key}) : super(key: key);

  @override
  State<ProductScreen2> createState() => _ProductScreen2State();
}

class _ProductScreen2State extends State<ProductScreen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          MainHeader(),
          Expanded(
              child: Obx((){
                if(productController.isProductLoading.value){
                  return const ProductLoadingGrid2();
                } else {
                  if(productController.productList.isNotEmpty){
                    return ProductGrid2(products: productController.productList);
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
          FloatingActionButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> CreateUser()));
          },child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.green,)
        ],
      ),
    );
  }

}



