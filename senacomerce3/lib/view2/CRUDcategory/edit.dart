import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:senacomerce3/model/category.dart';
import 'package:http/http.dart' as http;

import '../../customisation/text_field.dart';
import '../dashboard/dashboard_screen.dart';
class Editcategory extends StatefulWidget {
  final Category category;
  const Editcategory({Key? key, required this.category}) : super(key: key);

  @override
  State<Editcategory> createState() => _EditcategoryState();
}

class _EditcategoryState extends State<Editcategory> {
  @override
  void editUser({
    required Category category,
    required String name,
    required String image,


  }) async {
    @override

    const String url = "http://localhost:4410/api/categories/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Map<String, dynamic> dataBody = {
      "name": name,
      "image": image,


    };
    final response = await http.put(
      Uri.parse(url + category.id.toString()),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen2()));

    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
    TextEditingController(text: widget.category.name);
    TextEditingController imageController =
    TextEditingController(text: widget.category.image);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.0,
        title: const Text('Editar Producto'),
      ),
      body:
      SingleChildScrollView(
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
                  child:Center(
                    child:Padding(
                        padding: const EdgeInsets.only(
                            top: 100,
                            bottom: 100,
                            left: 18,
                            right: 18
                        ),
                        child:Center(
                          child:Container(
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
                                  const Padding(padding: EdgeInsets.all(40),
                                    child: Text(
                                      'Editar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(
                                        boxShadow: []
                                    ),
                                    child: Textfield(
                                        controller: nameController,
                                        onChanged: (val) {

                                          nameController.value =
                                              nameController.value.copyWith(text: val);
                                          // namecontroller.value =
                                          // namecontroller.value.copyWith(text: val);
                                        },
                                        textDirection: TextDirection.ltr,
                                        hinText: 'Nombre',
                                        hintStyle: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.redAccent
                                        ),
                                        icon: const Icon(
                                          Icons.production_quantity_limits,
                                          color: Colors.redAccent,
                                        )
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 300,
                                    decoration: const BoxDecoration(boxShadow: []),
                                    child: Textfield(
                                      controller: imageController,
                                      onChanged: (val) {

                                        imageController.value =
                                            imageController.value.copyWith(text: val);
                                        // emailController.value =
                                        // emailController.value.copyWith(text: val);
                                      },
                                      textDirection: TextDirection.ltr,
                                      hinText: 'URL',
                                      hintStyle: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.redAccent
                                      ),
                                      icon: const Icon(
                                        Icons.image,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),


                                  const SizedBox(
                                    height: 10,
                                  ),

                                  SizedBox(
                                    width: 100,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.green
                                      ),
                                      onPressed: () {
                                        editUser(
                                          category: widget.category,
                                          name: nameController.text,
                                          image: imageController.text,



                                        );

                                      },
                                      child: const Text('Save'),
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ),

                        )

                    ),


                  )

              )

            ],
          )



      ),
    );
  }
}
