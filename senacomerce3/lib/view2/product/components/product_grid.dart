import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:senacomerce3/view2/product/components/product_card.dart';
import 'package:senacomerce3/view2/product/components/product_card.dart';
import 'package:http/http.dart' as http;
import '../../../model/product.dart';
import '../../CartItem.dart';

class ProductGrid2 extends StatefulWidget {
  final List<Product> products;
  const ProductGrid2({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductGrid2> createState() => _ProductGrid2State();
}

class _ProductGrid2State extends State<ProductGrid2> {

  List<ShoppingCart> cartItems = [];

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

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2/3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ),
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: widget.products.length,
          itemBuilder: (context, index) => ProductCard2(product: widget.products[index]),
        );









  }
}

  
