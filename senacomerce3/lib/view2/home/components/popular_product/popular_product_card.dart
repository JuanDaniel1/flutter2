import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senacomerce3/const.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../../model/product.dart';
import '../../../dashboard/dashboard_screen.dart';

class PopularProductCard2 extends StatefulWidget {
  final Product product;
  const PopularProductCard2({Key? key, required this.product}) : super(key: key);

  @override
  State<PopularProductCard2> createState() => _PopularProductCard2State();
}


class _PopularProductCard2State extends State<PopularProductCard2> {
  void deleteUser() async{
    const String url = "http://localhost:4410/api/popular-products/";

    await http.delete(
        Uri.parse(url + widget.product.id.toString())
    );

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Material(
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 120,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 0.9,
                child: Image.network(
                  widget.product.images,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null)
                      return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  widget.product.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),
                  maxLines: 1,
                ),
              ),

              InkWell(
                child: Icon(Icons.delete),
                onTap: (){
                  deleteUser();
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> DashboardScreen2() ));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Producto popular "${widget.product.name}" eliminado'),
                        duration: Duration(seconds: 2),
                      ));

                },
              ),


            ],
          ),
        ),
      ),
    );
  }

}