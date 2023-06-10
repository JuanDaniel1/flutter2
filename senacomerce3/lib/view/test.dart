import 'dart:developer';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'CartItem.dart';


class PantallaCarrito extends StatefulWidget {

  const PantallaCarrito({Key? key}) : super(key: key);

  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();



}

class _PantallaCarritoState extends State<PantallaCarrito> {

  List<String> docIds = [];
  final _shoppingCart = ShoppingCart();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _shoppingCart.products.length,
              itemBuilder: (context, index) {
                final product = _shoppingCart.products[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        product.name,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        product.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        '\$${product.description}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                  ],
                );

              }
          )
        ],
      )

    );
  }
}
