import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senacomerce3/const.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/model/category.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../CRUDcategory/edit.dart';
import '../../dashboard/dashboard_screen.dart';


class CategoryCard2 extends StatefulWidget {
  final Category category;
  const CategoryCard2({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryCard2> createState() => _CategoryCard2State();
}
Category category = Category(id: 0, name: '', image: '');
class _CategoryCard2State extends State<CategoryCard2> {
  void deleteUser() async{
    const String url = "http://localhost:4410/api/categories/";

    await http.delete(
        Uri.parse(url + widget.category.id.toString())
    );

  }
  bool _selected = false;
  bool _hovering = false;

  Future save() async {
    const String url = "http://localhost:4410/api/popular-categories/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "category":[{"id": widget.category.id}]

    };
    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen2()));


  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        onTap: (){
          setState(() {
            _selected = !_selected;
          });
        },
        child: CachedNetworkImage(
          imageUrl: widget.category.image,
          imageBuilder: (context, imageProvider) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height: _selected ? 200 : 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: const Alignment(-1, 0),
                          child: Text(
                            "id: " +
                            widget.category.id.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(-1, 0),
                          child: Text(
                            widget.category.name,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            dashboardController.updateIndex(1);
                            productController.searchTextEditController.text = 'cat: ${widget.category.name}';
                            productController.searchVal.value = 'cat: ${widget.category.name}';
                            productController.getProductByCategory(id: widget.category.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(Radius.circular(24))
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8
                              ),
                              child: Text(
                                'Ver mas',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                save();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Se agrego "${widget.category.name}" a categorias populares'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            },
                            icon: Icon(
                              Icons.star,
                              size: 24,
                              color: Colors.yellow,
                            ),
                          ),

                        ),
                        InkWell(
                          child: Icon(Icons.edit,color: Colors.white,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Editcategory(category: widget.category,)));
                          },
                        ),
                        InkWell(
                          child: Icon(Icons.delete,color: Colors.white,),
                          onTap: (){
                            setState(() {
                              deleteUser();
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen2()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('"${widget.category.name}"eliminado'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                            });
                          },
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
          placeholder: (context, url) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            child: Shimmer.fromColors(
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 100,
                          color: Colors.grey,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: const BorderRadius.all(Radius.circular(24))
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8
                            ),
                            child: Text(
                              'Ver mas',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white),
          ),
          errorWidget: (context, url, error) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}