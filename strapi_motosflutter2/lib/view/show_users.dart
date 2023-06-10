import 'dart:core';
import 'dart:core';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_motosflutter/view/add_user.dart';
import 'package:strapi_motosflutter/view/user.dart';
import 'package:strapi_motosflutter/view/user_detail.dart';
import 'dart:convert';

class DisplayUsers extends StatefulWidget {
  const DisplayUsers({Key? key}) : super(key: key);

  @override
  State<DisplayUsers> createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers> {


  late Future<List<Motos>>_listamotos;
  List<Motos>motos=[];

  Future<List<Motos>> getAll() async {
    const String url = 'http://localhost:65400/api/motos/';

    var response = await http.get(
      Uri.parse(url)
    );

    if(response.statusCode==200){
      motos.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable motosData = decodedData.values;

    for (var item in motosData.elementAt(0)) {
      motos.add(Motos(
        item['id'],
        item['attributes']['marca'],
        item['attributes']['modelo'],
        item['attributes']['precio'],
        item['attributes']['distribuidor'],
        item['attributes']['foto'],
        item['attributes']['foto2'],
        item['attributes']['foto3'],
        item['attributes']['date'],
        item['attributes']['cilindraje'],

      ));
    }

    return motos;
  }
  final Map<String, String> dataHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  void initState() {
    super.initState();
    _listamotos = getAll();
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Motos'),
        elevation: 0.0,
        backgroundColor: Colors.orange[800],
      ),
      body: FutureBuilder(
        future: getAll(),
        builder: (context, AsyncSnapshot<List<Motos>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, index) =>
              InkWell(
                child: GridTile(
                  child:Card(
                    color: Colors.white,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(snapshot.data![index].marca,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Image.network(snapshot.data![index].foto,width: 300,height: 400,),
                        ElevatedButton(onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) =>
                                  MotoDetails(
                                    motos: snapshot.data![index],
                                  ))
                          );
                        }, child: Text(
                            'Detalles'
                        ))
                      ],
                    ),
                  )



                ),
              ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );

        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CreateUser()));
        },
        child: const Icon(
          Icons.add
        ),
        backgroundColor: Colors.redAccent

      ),
    );
  }
  List<Widget> _listmotos(List<Motos> data) {

    List<Widget> motoss = [];

    for (var motos in data) {

      motoss.add(
          GestureDetector(
            child: Card(
              color: Colors.white54,
              child: Column(
                children: [
                  Expanded(child: Image.network(motos.foto, fit: BoxFit.fill,scale: 1,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(motos.marca ),
                  )
                ],
              ),
            ),
            onLongPress: () {
              setState(() {
                showDialog(context: context, builder: (context) => AlertDialog(
                    title: Text(motos.marca),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.network(motos.foto,fit: BoxFit.fill,),
                          SizedBox(height: 20,),
                          Text('Modelo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Marca',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(motos.marca,style: TextStyle(fontWeight: FontWeight.w400),),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text('Fecha viral',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          const SizedBox(
                            height: 10,
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: const Text('Atras'), )
                        ],
                      ),
                    )
                ));
              });
            },
          )

      );
    }
    return motoss;
  }


}
