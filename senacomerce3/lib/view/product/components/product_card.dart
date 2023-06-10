import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senacomerce3/const.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/product.dart';
import '../../product_details/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product,

            )));
      },
      child: Material(
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: Hero(
                      tag: product.images,
                      child: Image.network(product.images,
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.name + "/" + product.medida,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



