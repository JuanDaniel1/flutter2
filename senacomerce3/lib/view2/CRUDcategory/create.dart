import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senacomerce3/model/category.dart';

import '../../customisation/text_field.dart';
import '../../model/product.dart';
import '../dashboard/dashboard_screen.dart';

class Createcategory extends StatefulWidget {
  const Createcategory({Key? key}) : super(key: key);

  @override
  State<Createcategory> createState() => _CreatecategoryState();
}
Category category = Category(id: 0, name: '', image: '');

class _CreatecategoryState extends State<Createcategory> {
  final TextEditingController _nameController =
  TextEditingController(text: category.name);
  final TextEditingController _imageController =
  TextEditingController(text: category.image);

  void dispose(){
    super.dispose();
    _nameController.dispose();
    _imageController.dispose();
  }
  Future save() async {
    const String url = "http://localhost:4410/api/categories/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "name": _nameController.text,
      "image": _imageController.text,

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.0,
        title: const Text('Agregar Producto popular'),
      ),
      body: SingleChildScrollView(
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
                          height: 400,
                          width: 350,
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
                                      Icons.text_fields,
                                      color: Colors.redAccent,
                                    ),


                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  width: 300,
                                  decoration: const BoxDecoration(boxShadow: []),
                                  child: Textfield(
                                    controller: _imageController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'URL',
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.redAccent,
                                    ),
                                    icon: const Icon(
                                      Icons.image,
                                      color: Colors.redAccent,
                                    ),


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


      ),
    );
  }
}
