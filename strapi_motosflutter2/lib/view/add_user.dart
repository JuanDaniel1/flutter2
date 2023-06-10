import 'package:flutter/material.dart';
import 'package:strapi_motosflutter/customisation/text_field.dart';
import 'package:strapi_motosflutter/view/ResponsiveLayout/Layout.dart';
import 'package:strapi_motosflutter/view/show_users.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_motosflutter/view/user.dart';
import 'dart:convert';
import 'dart:async';

class CreateUser extends StatefulWidget {

  final int? id;

  const CreateUser({Key? key, this.id});


  @override
  State<CreateUser> createState() => _CreateUserState();
}

Motos motos = Motos(0, '', '', '', '', '','','','','');

class _CreateUserState extends State<CreateUser> {

  final TextEditingController _marcaController =
      TextEditingController(text: motos.marca);
  final TextEditingController _modeloController =
      TextEditingController(text: motos.modelo);
  final TextEditingController _cilindrajeController =
  TextEditingController(text: motos.modelo);
  final TextEditingController _dateController =
  TextEditingController(text: motos.modelo);
  final TextEditingController _fotoController =
      TextEditingController(text: motos.foto);
  final TextEditingController _foto2Controller =
  TextEditingController(text: motos.foto2);
  final TextEditingController _foto3Controller =
  TextEditingController(text: motos.foto3);
  final TextEditingController _precioController =
  TextEditingController(text: motos.precio);
  final TextEditingController _distribuidorController =
  TextEditingController(text: motos.distribuidor);

  @override

  void dispose(){
    super.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    _cilindrajeController.dispose();
    _dateController.dispose();
    _fotoController.dispose();
    _foto2Controller.dispose();
    _foto3Controller.dispose();
    _precioController.dispose();
    _distribuidorController.dispose();
  }

  Future save() async {
    const String url = "http://localhost:65400/api/motos/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "modelo": motos.modelo,
      "marca": motos.marca,
      "date": motos.date,
      "cilindraje": motos.cilindraje,
      "foto": motos.foto,
      "foto2": motos.foto2,
      "foto3": motos.foto3,
      "precio": motos.precio,
      "distribuidor": motos.distribuidor,

    };

    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );
    Navigator.pushAndRemoveUntil<void>(context, MaterialPageRoute<void>(builder: (BuildContext context) =>
    const ResponsiveLayout()) as Route<void>,
        (Route<dynamic> route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        elevation: 0.0,
        title: const Text('Agregar moto'),
      ),
      body: SingleChildScrollView(
        child:Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/fondo.jpg'),fit: BoxFit.cover
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
                        height: 850,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[
                              Color(0xFFFFE0B2),
                              Color(0XFFFFB74D)])
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
                                  controller: _marcaController,

                                  textDirection: TextDirection.ltr,
                                  hinText: 'Marca',
                                  hintStyle: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.redAccent,
                                  ),
                                  icon: const Icon(
                                    Icons.motorcycle,
                                    color: Colors.redAccent,
                                  ),


                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _modeloController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'Modelo',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.data_exploration_rounded,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _dateController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'Año',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.date_range,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _cilindrajeController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'Cilindraje',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.chrome_reader_mode_outlined,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),

                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _precioController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'Precio',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.price_check,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _distribuidorController,
                                    textDirection: TextDirection.ltr,
                                    hinText: 'Distribuidor',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.business_sharp,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _fotoController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'URL',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.format_underline_outlined,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _foto2Controller,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'URL2',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.format_underline_outlined,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),
                              Container(
                                width: 300,
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Textfield(
                                    controller: _foto3Controller,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'URL3',
                                    hintStyle: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.redAccent
                                    ),
                                    icon: const Icon(
                                      Icons.format_underline_outlined,
                                      color: Colors.redAccent,
                                    )
                                ),
                              ),

                              SizedBox(
                                width: 100,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white
                                  ),
                                  onPressed: save,
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
