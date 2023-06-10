
import 'package:flutter/material.dart';
import 'package:strapi_motosflutter/customisation/text_field.dart';
import 'package:strapi_motosflutter/view/ResponsiveLayout/Layout.dart';
import 'package:strapi_motosflutter/view/add_user.dart';
import 'package:strapi_motosflutter/view/show_users.dart';
import 'package:strapi_motosflutter/view/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditMoto extends StatefulWidget {

  final motos;
  const EditMoto({super.key, required this.motos});

  @override
  State<EditMoto> createState() => _EditMotoState();
}

class _EditMotoState extends State<EditMoto> {

  void editUser({
    required Motos motos,
    required String marca,
    required String modelo,
    required String date,
    required String cilindraje,
    required String foto,
    required String foto2,
    required String foto3,
    required String precio,
    required String distribuidor,

}) async {
    @override

    const String url = "http://localhost:65400/api/motos/";

    final Map<String, String> dataHeader = {
      'Access-Control-Allow-Methods': '[GET, POST, PUT, DELETE, HEAD, OPTIONS]',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Map<String, dynamic> dataBody = {
      "marca": marca,
      "modelo": modelo,
      "date": date,
      "cilindraje": cilindraje,
      "foto": foto,
      "foto2": foto2,
      "foto3": foto3,
      "precio": precio,
      "distribuidor": distribuidor,
    };
    final response = await http.put(
      Uri.parse(url + motos.id.toString()),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => const ResponsiveLayout()
      ), (Route<dynamic> route) => false);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController marcaController =
    TextEditingController(text: widget.motos.marca);
    TextEditingController modeloController =
    TextEditingController(text: widget.motos.modelo);
    TextEditingController dateController =
    TextEditingController(text: widget.motos.date);
    TextEditingController cilindrajeController =
    TextEditingController(text: widget.motos.cilindraje);
    TextEditingController fotoController =
    TextEditingController(text: widget.motos.foto);
    TextEditingController foto2Controller =
    TextEditingController(text: widget.motos.foto2);
    TextEditingController foto3Controller =
    TextEditingController(text: widget.motos.foto3);
    TextEditingController precioController =
    TextEditingController(text: widget.motos.precio);
    TextEditingController distribuidorController =
    TextEditingController(text: widget.motos.distribuidor);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        elevation: 0.0,
        title: const Text('Editar Moto'),
      ),
      body:
      SingleChildScrollView(
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
                                            controller: marcaController,
                                            onChanged: (val) {

                                              marcaController.value =
                                                  marcaController.value.copyWith(text: val);
                                              // namecontroller.value =
                                              // namecontroller.value.copyWith(text: val);
                                            },
                                            textDirection: TextDirection.ltr,
                                            hinText: 'Marca',
                                            hintStyle: const TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.redAccent
                                            ),
                                            icon: const Icon(
                                              Icons.motorcycle,
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
                                          controller: modeloController,
                                          onChanged: (val) {

                                            modeloController.value =
                                                modeloController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'Modelo',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.data_exploration,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: dateController,
                                          onChanged: (val) {

                                            dateController.value =
                                                dateController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'Año',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.date_range,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: cilindrajeController,
                                          onChanged: (val) {

                                            cilindrajeController.value =
                                                cilindrajeController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'Cilindraje',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.chrome_reader_mode_outlined,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: fotoController,
                                          onChanged: (val) {
                                            fotoController.value =
                                                fotoController.value.copyWith(text: val);
                                            // passwordController.value =
                                            //passwordController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'URL',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.format_underline_outlined,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: foto2Controller,
                                          onChanged: (val) {
                                            foto2Controller.value =
                                                foto2Controller.value.copyWith(text: val);
                                            // passwordController.value =
                                            //passwordController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'URL2',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.format_underline_outlined,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: foto3Controller,
                                          onChanged: (val) {
                                            foto3Controller.value =
                                                foto3Controller.value.copyWith(text: val);
                                            // passwordController.value =
                                            //passwordController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'URL3',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.format_underline_outlined,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: precioController,
                                          onChanged: (val) {

                                            precioController.value =
                                                precioController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'Precio',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.monetization_on,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: distribuidorController,
                                          onChanged: (val) {

                                            distribuidorController.value =
                                                distribuidorController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'Distribuidor',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.business_sharp,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: 100,
                                        child: TextButton(
                                          style:
                                          TextButton.styleFrom(backgroundColor: Colors.white),
                                          onPressed: () {
                                            editUser(
                                              motos: widget.motos,
                                              marca: marcaController.text,
                                              modelo: modeloController.text,
                                              date: dateController.text,
                                              cilindraje: cilindrajeController.text,
                                              foto: fotoController.text,
                                              foto2: foto2Controller.text,
                                              foto3: foto3Controller.text,
                                              precio: precioController.text,
                                              distribuidor: distribuidorController.text,


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
