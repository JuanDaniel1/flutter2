import 'dart:convert';
import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


import 'package:senacomerce3/view2/product/components/product_card.dart';
import '../model/product.dart';

import '../view/product/components/product_card.dart';
import 'CRUD/create.dart';
import 'CRUD/create.dart';
import 'CartItem.dart';

class PantallaCarrito2 extends StatefulWidget {

  final List<Product> products;
  final carrito=Carrito(id: 0, name: '', description: '', images: '', price: 0, qty: 1);
  final List<Carrito> carritos;
  final product = Product(id: 0, name: '', description: '', images: '', price: 0, medida: '');
  PantallaCarrito2({Key? key, required this.products, required this.carritos})
      : super(key: key);

  @override
  _PantallaCarrito2State createState() => _PantallaCarrito2State();
}

class _PantallaCarrito2State extends State<PantallaCarrito2> {
  double subtotal=0;
  Future<List<Carrito>> getProducts() async {

    final response =
    await http.get(Uri.parse('http://localhost:4410/api/carritos'));
    if (response.statusCode == 200) {
      widget.carritos.clear();
    } else {
      throw Exception('Failed to load products');
    }
    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;
    for (var item in motosData.elementAt(0)) {
      widget.carritos.add(Carrito(
        id: item['id'],
        name: item['attributes']['name'],
        description: item['attributes']['description'],
        images: item['attributes']['images'],
        price: item['attributes']['price'], qty: item['attributes']['cant'],
      ));
      subtotal += item['attributes']['price'] * item['attributes']['cant'];
    }
    return widget.carritos;
  }

  void deleteUser() async {
    const String url = "http://localhost:4410/api/carritos/";

    await http.delete(Uri.parse(url + widget.carrito.id.toString()));
  }
  double precio=0;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.lightGreen[800],
      appBar: AppBar(
        title: Text('Mi carrito'),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<List<Carrito>> snapshot) {
          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: widget.carritos.length,
                    itemBuilder: (context, index) {
                      precio = snapshot.data![index].qty*snapshot.data![index].price;
                      return Column(
                        children: [
                          Card(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Image.network(
                                    snapshot.data![index].images,
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(snapshot.data![index].name),
                                          Text('Precio: '+snapshot.data![index].price.toString(), style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                          Text(
                                              "Cantidad: " +
                                                  snapshot.data![index].qty
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 70,
                                    decoration:
                                    BoxDecoration(color: Color(0x99f0f0f0)),
                                    child: Center(
                                      child: Text(
                                        "\$" +
                                            (precio)
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: Icon(
                                          Icons.delete
                                      ),
                                      onTap: (){
                                        setState(() async {

                                          const String url = "http://localhost:4410/api/carritos/";

                                          await http.delete(Uri.parse(url + widget.carritos[index].id.toString()));
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>PantallaCarrito2(products: widget.products, carritos: widget.carritos)));
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )),
                        ],
                      );

                    } ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("SubTotal: ", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


                    Text("\$"+(subtotal).toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 29),),
                  ],
                ),
              ),


            ],
          );

        },future: getProducts(),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        backgroundColor: Colors.green,
        onPressed: (){

        },
      ),

    );
  }
}
