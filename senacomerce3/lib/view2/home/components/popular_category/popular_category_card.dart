import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senacomerce3/const.dart';
import 'package:senacomerce3/model/category.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../dashboard/dashboard_screen.dart';

class PopularCategoryCard2 extends StatefulWidget {
  final Category category;
  const PopularCategoryCard2({Key? key, required this.category}) : super(key: key);

  @override
  State<PopularCategoryCard2> createState() => _PopularCategoryCard2State();
}

class _PopularCategoryCard2State extends State<PopularCategoryCard2> {
  void deleteUser() async{
    const String url = "http://localhost:4410/api/popular-categories/";

    await http.delete(
        Uri.parse(url + widget.category.id.toString())
    );

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: CachedNetworkImage(
        imageUrl: widget.category.image,
        imageBuilder: (context, imageProvider) => Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 270,
            height: 140,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.category.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.delete,color: Colors.white,),
                      onTap: (){
                       deleteUser();
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> DashboardScreen2() ));
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text('Categoria popular "${widget.category.name}" eliminado'),
                           duration: Duration(seconds: 2),
                         ),
                       );

                      },
                    ),
                  ],
                )

            ),
          ),
        ),
        placeholder: (context, url) => Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              width: 270,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 270,
            height: 140,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)
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
    );
  }
}