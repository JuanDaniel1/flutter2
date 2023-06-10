import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:http/http.dart' as http;
import '../../customisation/text_field.dart';
import '../../model/product.dart';
import '../../route/app_route.dart';
import '../../view/dashboard/dashboard_binding.dart';
import '../../view/dashboard/dashboard_screen.dart';

class Createpopular extends StatefulWidget {
  const Createpopular({Key? key}) : super(key: key);

  @override
  State<Createpopular> createState() => _CreatepopularState();
}
Product product = Product(id: 0, description: '', name: '', images: '', price: 0, medida: '');


class _CreatepopularState extends State<Createpopular> {
  final TextEditingController _idController =
  TextEditingController(text: product.id.toString());

  @override

  void dispose(){
    super.dispose();
    _idController.dispose();

  }

  Future save() async {
    const String url = "http://localhost:4410/api/popular-products/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "product":[{"id": _idController.text}]

    };
    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
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
                          height: 300,
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
                                    controller: _idController,

                                    textDirection: TextDirection.ltr,
                                    hinText: 'ID',
                                    hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.redAccent,
                                    ),
                                    icon: const Icon(
                                      Icons.numbers,
                                      color: Colors.redAccent,
                                    ),


                                  ),
                                ),
                                const SizedBox(height: 10,),

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
