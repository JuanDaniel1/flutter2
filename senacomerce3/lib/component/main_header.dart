import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/controller/home_controller.dart';
import 'package:senacomerce3/service/local_service/local_category_service.dart';
import 'package:senacomerce3/view/account/auth/sign_in_screen.dart';
import 'package:senacomerce3/view2/dashboard/dashboard_screen.dart';
import 'package:senacomerce3/view2/test.dart';
import '../model/product.dart';
import '../service/local_service/local_ad_banner_service.dart';
import '../service/local_service/local_product_service.dart';
import '../view/CartItem.dart';
import '../view/test.dart';
import 'package:http/http.dart' as http;


class MainHeader extends StatefulWidget {
  MainHeader({Key? key}) : super(key: key);
  final products = <Product>[];
  final carrito = <Carrito>[];
  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('http://localhost:4410/api/products'));
    if (response.statusCode == 200) {
      widget.products.clear();
    }
    else {
      throw Exception('Failed to load products');
    }
    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;
    for (var item in motosData.elementAt(0)) {
      widget.products.add(Product(id: item['id'], name: item['attributes']['name'], description: item['attributes']['description'],
        images: item['attributes']['images'], price: item['attributes']['price'], medida: item['attributes']['medida'],


      ));
    }
    return widget.products;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 10
            )
          ]
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                    Radius.circular(24)
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(0,0),
                      blurRadius: 8
                  )
                ]
            ),
            child: Obx(()=>TextField(
              autofocus: false,
              controller: productController.searchTextEditController,
              onSubmitted: (val){
                productController.getProductByName(keyword: val);
                dashboardController.updateIndex(1);
              },
              onChanged: (val){
                productController.searchVal.value = val;
              },
              decoration: InputDecoration(
                  suffixIcon: productController.searchVal.value.isNotEmpty?
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      productController.searchTextEditController.clear();
                      productController.searchVal.value = '';
                      productController.getProducts();
                    },
                  ): null,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none
                  ),
                  hintText: "Buscar...",
                  prefixIcon: const Icon(Icons.search)
              ),
            )),
          )),
          const SizedBox(width: 10),
          InkWell(
            child:Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 8
                    )
                  ]
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.refresh,
                color: Colors.grey,),
            ),
            onTap: (){
              setState(() {

              });
            },
          ),

          const SizedBox(width: 10),
          badges.Badge(
              badgeContent: const Text("1",
                style: TextStyle(
                    color: Colors.white
                ),),
              badgeStyle: badges.BadgeStyle(
                  badgeColor:  Colors.lightGreen
              ),
              child: GestureDetector(
                child:Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 8
                        )
                      ]
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.grey,),
                ),
                onTap: (){
                  if(authController.user.value == null){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
                    => SignInScreen()
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Debes iniciar sesion'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PantallaCarrito2( products: widget.products, carritos: widget.carrito,)));
                  }

                },
              )

          ),
          const SizedBox(width: 5),
        ],
      ),
    );

  }
}







