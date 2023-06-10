import 'package:flutter/material.dart';
import 'package:senacomerce3/view2/home/components/popular_product/popular_product_loading_card.dart';

class PopularProductLoading2 extends StatelessWidget {
  const PopularProductLoading2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => const PopularProductLoadingCard2()),
    );
  }
}