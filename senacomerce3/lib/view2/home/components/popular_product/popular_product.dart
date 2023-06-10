import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:senacomerce3/view/home/components/popular_product/popular_product_card.dart';
import 'package:http/http.dart' as http;
import 'package:senacomerce3/view2/home/components/popular_product/popular_product_card.dart';

import '../../../../model/product.dart';

class PopularProduct2 extends StatefulWidget {
  final List<Product> popularProducts;
  final List<Popular> popular = [];

  PopularProduct2({Key? key, required this.popularProducts}) : super(key: key);

  @override
  State<PopularProduct2> createState() => _PopularProduct2State();
}

class _PopularProduct2State extends State<PopularProduct2> {
  Future<List<Product>> getAll() async {
    const String url = 'http://localhost:4410/api/popular-products?populate=product';

    var response = await http.get(
        Uri.parse(url)
    );

    if(response.statusCode==200){
      widget.popularProducts.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;
    for (var item in motosData.elementAt(0)) {

      widget.popularProducts.add(Product(
        id: item['id'],
        name: item['attributes']['product']['data']['attributes']['name'],
        description: item['attributes']['product']['data']['attributes']
        ['description'],
        images: item['attributes']['product']['data']['attributes']
        ['images'],
        price: item['attributes']['product']['data']['attributes']
        ['price'],
        medida: item['attributes']['product']['data']['attributes']
        ['medida'],




      ));
    }

    return widget.popularProducts;
  }
  final Map<String, String> dataHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, AsyncSnapshot<List<Product>> snapshot){
      return Container(
        height: 220,
        padding: const EdgeInsets.only(right: 10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.popularProducts.length,
            itemBuilder: (context, index) => PopularProductCard2(product: widget.popularProducts[index])),
      );
    },future: getAll(),);

  }
}