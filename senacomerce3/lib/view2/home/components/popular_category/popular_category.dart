import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:senacomerce3/model/category.dart';
import 'package:http/http.dart' as http;


import '../../../../view/home/components/popular_category/popular_category_card.dart';
import 'popular_category_card.dart';

class PopularCategory extends StatefulWidget {
  final List<Category> categories;
  final List<PopCat> populares=[];
  PopularCategory({Key? key, required this.categories}) : super(key: key);

  @override
  State<PopularCategory> createState() => _PopularCategoryState();
}

class _PopularCategoryState extends State<PopularCategory> {
  Future<List<Category>> getAll() async {
    const String url = 'http://localhost:4410/api/popular-categories?populate=category';

    var response = await http.get(
        Uri.parse(url)
    );

    if(response.statusCode==200){
      widget.categories.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;

    for (var item in motosData.elementAt(0)) {
      widget.categories.add(Category(
          id: item['id'],
          name: item['attributes']['category']['data']['attributes']['name'],
          image: item['attributes']['category']['data']['attributes']['image'],
      )


      );
    }

    return widget.categories;
  }
  final Map<String, String> dataHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, AsyncSnapshot<List<Category>> snapshot){
      return Container(
        height: 140,
        padding: const EdgeInsets.only(right: 10),

        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.categories.length,
            itemBuilder: (context, index) => PopularCategoryCard2(
                category: widget.categories[index]
            )
        ),
      );
    },future: getAll());

  }
}