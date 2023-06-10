
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';
import 'package:senacomerce3/route/app_route.dart';
import 'package:senacomerce3/model/product.dart';
import 'package:senacomerce3/view2/CRUD/create.dart';
import 'package:senacomerce3/view2/dashboard/dashboard_screen.dart';

import '../../customisation/text_field.dart';
import '../../model/category.dart';
import '../../view/dashboard/dashboard_binding.dart';
import '../../view/dashboard/dashboard_screen.dart';

class EditMoto extends StatefulWidget {

  final Product product;
  const EditMoto({super.key, required this.product});

  @override
  State<EditMoto> createState() => _EditMotoState();
}
List<Category>categories = [];

class _EditMotoState extends State<EditMoto> {
  Future<List<Category>> getAll() async {
    const String url = 'http://localhost:4410/api/categories/';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      widget.product.selected.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;

    for (var item in motosData.elementAt(0)) {
      categories.add(Category(
        id: item['id'],
        name: item['attributes']['name'],
        image: item['attributes']['image'],
      ));
    }

    return categories;
  }


  void editUser({
    required Product product,
    required String name,
    required String description,
    required String images,
    required double price,
    required String medida,


  }) async {
    @override

    const String url = "http://localhost:4410/api/products/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Map<String, dynamic> dataBody = {
      "name": name,
      "description": description,
      "images": images,
      "price": price,
      "medida": medida,
      "categories": widget.product.selected,

    };
    final response = await http.put(
      Uri.parse(url + product.id.toString()),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DashboardScreen2()));
      GetPage(
          name: AppRoute.dashboard,
          page: () => const DashboardScreen(),
          binding: DashboardBinding2()

      );
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
    TextEditingController(text: widget.product.name);
    TextEditingController descriptionController =
    TextEditingController(text: widget.product.description);
    TextEditingController imagesController =
    TextEditingController(text: widget.product.images);
    TextEditingController priceController =
    TextEditingController(text: widget.product.price.toString());
    TextEditingController medidaController =
    TextEditingController(text: widget.product.medida);





    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.0,
        title: const Text('Editar Producto'),
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
                                          controller: descriptionController,
                                          onChanged: (val) {

                                            descriptionController.value =
                                                descriptionController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'Descripcion',
                                          hintStyle: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.redAccent
                                          ),
                                          icon: const Icon(
                                            Icons.text_fields,
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
                                          controller: imagesController,
                                          onChanged: (val) {

                                            imagesController.value =
                                                imagesController.value.copyWith(text: val);
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
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: priceController,
                                          onChanged: (val) {

                                            priceController.value =
                                                priceController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'precio',
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

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: Textfield(
                                          controller: medidaController,
                                          onChanged: (val) {

                                            medidaController.value =
                                                medidaController.value.copyWith(text: val);
                                            // emailController.value =
                                            // emailController.value.copyWith(text: val);
                                          },
                                          textDirection: TextDirection.ltr,
                                          hinText: 'medida',
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
                                      Container(
                                        width: 300,
                                        decoration: const BoxDecoration(boxShadow: []),
                                        child: MultiSelectDialogField(
                                          items: categories
                                              .map((e) => MultiSelectItem(e.id.toString(), e.name))
                                              .toList(),
                                          initialValue: widget.product.selected,
                                          onConfirm: (values) {
                                            setState(() {
                                              widget.product.selected = values.cast();
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
                                          onPressed: () {
                                            double price = double.parse(priceController.text);
                                            editUser(
                                              product: widget.product,
                                              name: nameController.text,
                                              description: descriptionController.text,
                                              images: imagesController.text,
                                              price: price,
                                              medida: medidaController.text,




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



          );

      },future: getAll(),)

    );
  }
}