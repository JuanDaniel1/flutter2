import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/view2/category/components/category_card.dart';
import 'package:http/http.dart' as http;

import '../../model/category.dart';
import '../CRUDcategory/create.dart';

class CategoryScreen2 extends StatefulWidget {
  const CategoryScreen2({Key? key}) : super(key: key);

  @override
  State<CategoryScreen2> createState() => _CategoryScreen2State();
}

class _CategoryScreen2State extends State<CategoryScreen2> {
  List<Category> category = [];

  Future<List<Category>> getAll() async {
    const String url = 'http://localhost:4410/api/categories/';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      category.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;

    for (var item in motosData.elementAt(0)) {
      category.add(Category(
        id: item['id'],
        name: item['attributes']['name'],
        image: item['attributes']['image'],
      ));
    }

    return category;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<Category>> snapshot) {
        return Column(
          children: [
            Expanded(child: Obx(() {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => CategoryCard2(
                      category: snapshot.data![index]),
                );
              } else {
                return Container();
              }
            })),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Createcategory()));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.green,
            )
          ],
        );
      },future: getAll(),);
  }
}