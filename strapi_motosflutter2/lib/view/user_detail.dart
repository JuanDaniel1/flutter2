
import 'package:flutter/material.dart';
import 'package:strapi_motosflutter/view/edit_user.dart';
import 'package:strapi_motosflutter/view/show_users.dart';
import 'package:strapi_motosflutter/view/user.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

import 'ResponsiveLayout/Layout.dart';

class MotoDetails extends StatefulWidget {
  final Motos motos;
  const MotoDetails({Key? key, required this.motos}) : super(key: key);

  @override
  State<MotoDetails> createState() => _MotoDetailsState();
}

class _MotoDetailsState extends State<MotoDetails> {

  @override
  Widget build(BuildContext context) {
    List _carrusel = [
      widget.motos.foto,
      widget.motos.foto2,
      widget.motos.foto3
    ];
    int currentIndex = 0;
    void deleteUser() async{
      const String url = "http://localhost:65400/api/motos/";
      
      await http.delete(
        Uri.parse(url + widget.motos.id.toString())
      );
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => const ResponsiveLayout()
      ),
          (Route<dynamic> route) => false
        
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Moto Detalles'),
        elevation: 0.0,
        backgroundColor: Colors.orange[800],
      ),
      body: SingleChildScrollView(
        child:Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 32
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: 600,
                  height: 700,
                  child:Card(
                    elevation: 10,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 32
                      ),
                      child: Column(
                        children: [
                      CarouselSlider(
                      items: _carrusel.map((image) {
                    return Container(
                    child: Image.network(image, fit: BoxFit.cover),
                    );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 7),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Marca:',style: TextStyle(fontSize: 25,color: Colors.red,),),
                              Text('Modelo:',style: TextStyle(fontSize: 25,color: Colors.red,),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(widget.motos.marca,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Text(widget.motos.modelo,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),


                          SizedBox(height: 30,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Año:',style: TextStyle(fontSize: 25,color: Colors.red,),),
                              Text('Precio:',style: TextStyle(fontSize: 25,color: Colors.red,),),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(widget.motos.date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text(widget.motos.precio,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Cilindraje:',style: TextStyle(fontSize: 25,color: Colors.red,),),
                              Text('Distribuidor:',style: TextStyle(fontSize: 25,color: Colors.red,),),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(widget.motos.cilindraje,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Text(widget.motos.distribuidor,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 50,
                                child:ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (_) => EditMoto(motos: widget.motos,)));
                                  }, child: const Text('Edit'),

                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.black
                                      ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(onPressed: (){
                                  deleteUser();
                                },child: const Text('Delete'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.black
                                      )
                                  ),),
                              )


                            ],
                          )







                        ],
                      ),



                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      )

    );
  }
}
