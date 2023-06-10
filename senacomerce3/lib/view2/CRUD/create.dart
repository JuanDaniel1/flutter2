
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:senacomerce3/main.dart';
import 'package:senacomerce3/view/dashboard/dashboard_binding.dart';
import 'package:senacomerce3/view2/dashboard/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:senacomerce3/view2/product/product_screen.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';
import 'dart:async';

import '../../customisation/text_field.dart';
import '../../model/category.dart';
import '../../model/product.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/dashboard/dashboard_screen.dart';
import 'package:senacomerce3/route/app_route.dart';

class CreateUser extends StatefulWidget {



  CreateUser({Key? key});


  @override
  State<CreateUser> createState() => _CreateUserState();
}
Product product = Product(id: 0, description: '', name: '', images: '', price: 0, medida: '');
List<Product>products = [];
List<Category>category = [];



class _CreateUserState extends State<CreateUser> {




  final TextEditingController _descriptionController =
  TextEditingController(text: product.description);
  final TextEditingController _nameController =
  TextEditingController(text: product.name);
  final TextEditingController _imagesController =
  TextEditingController(text: product.images);
  final TextEditingController _priceController =
  TextEditingController(text: product.price.toString());
  final TextEditingController _medidaController =
  TextEditingController(text: product.medida);




  @override

  void dispose(){
    super.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _imagesController.dispose();
    _priceController.dispose();
    _medidaController.dispose();
  }

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

  Future save() async {
    const String url = "http://localhost:4410/api/products/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "images": _imagesController.text,
      "price": _priceController.text,
      "medida": _medidaController.text,
      "categories": product.selected

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
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.0,
        title: const Text('Agregar Producto'),
      ),
      body: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        return SingleChildScrollView(
            child:Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Fondo.jpg'),fit: BoxFit.cover
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color(0xFFE8EAF6),
                              Color(0xFF7986CB)
                            ]
                        )
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 100,
                            bottom: 100,
                            left: 18,
                            right: 18
                        ),
                        child: Container(
                            height: 500,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[
                                  Color(0xFFAED581),
                                  Color(0XFF33691E)])
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.all(40),
                                    child: Text(
                                      'Agregar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: Textfield(
                                      controller: _nameController,

                                      textDirection: TextDirection.ltr,
                                      hinText: 'Nombre',
                                      hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent,
                                      ),
                                      icon: const Icon(
                                        Icons.production_quantity_limits,
                                        color: Colors.redAccent,
                                      ),


                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: Textfield(
                                        controller: _descriptionController,

                                        textDirection: TextDirection.ltr,
                                        hinText: 'Descripcion',
                                        hintStyle: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.redAccent
                                        ),
                                        icon: const Icon(
                                          Icons.text_fields,
                                          color: Colors.redAccent,
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: Textfield(
                                        controller: _imagesController,

                                        textDirection: TextDirection.ltr,
                                        hinText: 'URL',
                                        hintStyle: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.redAccent
                                        ),
                                        icon: const Icon(
                                          Icons.image,
                                          color: Colors.redAccent,
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: Textfield(
                                        controller: _priceController,

                                        textDirection: TextDirection.ltr,
                                        hinText: 'price',
                                        hintStyle: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.redAccent
                                        ),
                                        icon: const Icon(
                                          Icons.monetization_on,
                                          color: Colors.redAccent,
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: Textfield(
                                        controller: _medidaController,

                                        textDirection: TextDirection.ltr,
                                        hinText: 'medida',
                                        hintStyle: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.redAccent
                                        ),
                                        icon: const Icon(
                                          Icons.monetization_on,
                                          color: Colors.redAccent,
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: MultiSelectDialogField(
                                      buttonText: Text('Categorias'
                                      ),

                                      searchable: true,
                                      confirmText: Text("Ok",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 30),),
                                      cancelText: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 30),),
                                      items: category
                                          .map((e) => MultiSelectItem(e.id.toString(), e.name))
                                          .toList(),
                                      initialValue: product.selected,
                                      onConfirm: (values) {
                                        setState(() {
                                          product.selected = values.cast();
                                        });
                                      },
                                      title: Text('Categories'),
                                    ),

                                  ),

                                  SizedBox(
                                    width: 100,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.green
                                      ),
                                      onPressed: (){


                                        setState(() {
                                          save();
                                        });


                                      },
                                      child: const Text('Save'),
                                    ),
                                  )
                                ],
                              ),
                            )

                        ),
                      ),
                    )
                )
              ],
            )


        );
      },future: getAll(),)

    );
  }
}