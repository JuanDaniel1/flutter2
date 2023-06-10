import 'package:flutter/material.dart';
import 'package:senacomerce3/view/product/components/product_card.dart';

import '../../../model/product.dart';
import '../../CartItem.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  List<ShoppingCart> cartItems = [];
  ProductGrid({Key? key, required this.products}) : super(key: key);


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
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}