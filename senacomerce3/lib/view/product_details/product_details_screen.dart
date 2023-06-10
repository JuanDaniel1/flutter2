import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../controller/controllers.dart';
import '../../model/product.dart';
import '../../view2/account/auth/sign_in_screen.dart';
import '../CartItem.dart';
import 'components/product_carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final carrito=Carrito(id: 0, name: '', description: '', images: '', price: 0, qty: 1);


  ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  NumberFormat formatter = NumberFormat('00');
  int _qty = 1;
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
      "price": widget.product.price.toInt(),
      "cant": widget.carrito.qty

    };
    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    Navigator.pop(context);



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child:SafeArea(
            child:Column(
              children: [
                Center(
                    child: Container(
                        width: 400,
                        height: 800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(padding: EdgeInsets.all(10),
                                      child: Positioned(child: GestureDetector(
                                        child: Icon(Icons.arrow_back_ios_new_rounded),
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                      )
                                      )
                                  ),
                                  Image.network(
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
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      widget.product.name+'/'+widget.product.medida,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      '\$${widget.product.price}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
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
                                  ),


                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Acerca del producto:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      widget.product.description,
                                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: ElevatedButton(onPressed: (){
                                      setState(() {


                                        if(authController.user.value?.fullName == null){
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SignInScreen()));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Debes iniciar sesion'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                        else{
                                          carrito();

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Se agrego "${widget.product.name}" al carrito'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      });
                                    }, child: Text('Agregar'),style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            Colors.green
                                        )
                                    ),),
                                  )




                                ],
                              ),
                            ),
                          ],
                        )

                    )
                )
              ],
            )




        ),
      ),
    );
  }



}