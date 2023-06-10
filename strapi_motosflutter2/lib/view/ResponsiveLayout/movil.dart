import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../add_user.dart';
import '../user.dart';
import '../user_detail.dart';
class Movil extends StatefulWidget {
  const Movil({Key? key}) : super(key: key);

  @override
  State<Movil> createState() => _MovilState();
}

class _MovilState extends State<Movil> {
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
                        child: GestureDetector(
                          child:Card(
                            color: Colors.white,
                            child:Column(
                              children: [
                                Text(snapshot.data![index].modelo,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                Image.network(snapshot.data![index].foto, fit: BoxFit.fill,),
                              ],
                            ),
                          ),
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) =>
                                    MotoDetails(
                                      motos: snapshot.data![index],
                                    ))
                            );
                          },
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

}
