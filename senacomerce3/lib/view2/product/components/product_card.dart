import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:intl/intl.dart';
import 'package:senacomerce3/const.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../model/product.dart';
import '../../../route/app_route.dart';
import '../../../view/CartItem.dart';
import '../../../view/dashboard/dashboard_binding.dart';
import '../../../view/dashboard/dashboard_screen.dart';
import '../../CRUD/edit.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../product_details/product_details_screen.dart';

class ProductCard2 extends StatefulWidget {
  final Product product;
  final carrito=Carrito(id: 0, name: '', description: '', images: '', price: 0, qty: 1);
  ProductCard2({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCard2State createState() => _ProductCard2State();
}

class _ProductCard2State extends State<ProductCard2> {
  bool _isHovering = false;
  int _qty = 1;
  NumberFormat formatter = NumberFormat('00');
  final _shoppingCart = ShoppingCart();
  List<ShoppingCart> cartItems = [];
  Future carrito() async {
    const String url = "http://localhost:4410/api/carritos/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "name": widget.product.name.toString(),
      "description": widget.product.description.toString(),
      "images": widget.product.images.toString(),
      "price": widget.product.price,
      "cant": widget.carrito.qty,

    };

    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );


    Navigator.pop(context);



  }
  Future save() async {
    const String url = "http://localhost:4410/api/popular-products/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "product":[{"id": widget.product.id}]

    };
    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen2()));


  }


  @override
  void _addToCart(Product product) {
    setState(() {
      _shoppingCart.addProduct(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} agregado al carrito')),
    );
  }
  void deleteUser() async{
    const String url = "http://localhost:4410/api/products/";

    await http.delete(
        Uri.parse(url + widget.product.id.toString())
    );
    Navigator.pop(context);
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding2()


    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ProductDetailsScreen2(product: widget.product)));

      },
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
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
                  child: Stack(
                    children: [
                      Hero(
                        tag: widget.product.images,
                        child: Image.network(
                          widget.product.images,
                          width: 500,
                          height: 600,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
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
                      if (_isHovering)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                 save();
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Se agrego "${widget.product.name}" a productos populares'),
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
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Id: '+widget.product.id.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightGreen),
                    ),
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightGreen),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${widget.product.price}/U',
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
  Widget _buildDialogContent() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.carrito.qty > 1) {
                        setState(() {
                          widget.carrito.qty--;
                        });
                      }
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      size: 32,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    formatter.format(widget.carrito.qty),
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey.shade800),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.carrito.qty++;
                        if (widget.carrito.qty > 10) {
                          widget.carrito.qty = 10;
                        }
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right_sharp,
                      size: 32,
                      color: Colors.grey.shade800,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
