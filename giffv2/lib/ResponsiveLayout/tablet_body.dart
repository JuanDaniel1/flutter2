 import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;
 import 'package:giffv2/models/gif_app.dart';
import 'package:intl/intl.dart';
 import 'dart:convert';

import '../notificacion/notificacion.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  late Future<List<Gif>> _listadoGifs;

  //Future<List<Gif>> _listadoGifs; //Espera hasta que resuelva una peticion
  //Funcion que devuelve un objeto del tipo

  Future <List<Gif>> _getGifs() async {
    final stringUri = "https://api.giphy.com/v1/gifs/trending?api_key=L6OtgbhLMvBXVe217RxOyhfcZ6dMok2F&limit=$selected&rating=g";
    final response = await http.get(Uri.parse(stringUri));
    List<Gif> gifs = [];

    if(response.statusCode == 200) {
      //Verificamos que el RESPONSE este codificado UTF8
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body); //Convierte a un objeto Json

      for(var item in jsonData['data']){
        gifs.add(Gif(item['title'], item['images']['downsized']['url'],item['id'],item['trending_datetime'],item['username']));
      }

      //print (jsonData);
      //print (jsonData['data']);
      //print (jsonData['data'][0]);
      //print (jsonData['data'][0]['type']);
      print ('${gifs[0].name} ${gifs[0].url}');

    }else{

      throw Exception('Fallo la conexion');
    }
    return gifs;
  }
  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGifs();
  }
  List list_contador = ['1','5', '10', '15', '20'];
  List list_rango = ['g','pg','pg-13','r'];
  dynamic range = 'r';
  dynamic selected = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APIs Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: const Text('Giffs'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Column(
            children: [

              DropdownButtonFormField(
                hint: Text('Seleccione la cantidad'),
                items: list_contador.map((selected){
                  return DropdownMenuItem(
                    child: Text(selected),
                    value: selected,
                  );
                }).toList(),
                onChanged: (value){
                  setState(() =>
                  selected = value);
                  print(selected);
                  _listadoGifs = _getGifs();
                },
              ),
              DropdownButtonFormField(
                hint: Text('Seleccione el rango'),
                items: list_rango.map((range){
                  return DropdownMenuItem(
                    child: Text(range),
                    value: range,
                  );
                }).toList(),
                onChanged: (value){
                  setState(() =>
                  range = value);
                  print(range);
                  _listadoGifs = _getGifs();
                },
              ),

              Expanded(child: FutureBuilder(
                  future: _listadoGifs,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return GridView.count(
                        crossAxisCount: 4,
                        children: _listGifs(snapshot.data!),
                      );
                      return const Text('hola');
                    }else if (snapshot.hasError){
                      print(snapshot.hasError);
                      return const Text('error');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
              ))
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      String date = gif.trending_datetime;
      final parcedate = DateTime.parse(date);
      final formatofecha = DateFormat('dd/MMMM/yyyy').format(parcedate);
      gifs.add(
          GestureDetector(
            child: Card(
              color: Colors.white54,
              child: Column(
                children: [
                  Expanded(child: Image.network(gif.url, fit: BoxFit.fill,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(gif.name),
                  )
                ],
              ),
            ),
            onLongPress: () {
              setState(() {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text(gif.name),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.network(gif.url,fit: BoxFit.fill,),
                        Text('Nombre de Usuario',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(gif.username,style: TextStyle(fontWeight: FontWeight.w400),),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Id',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(gif.id,style: TextStyle(fontWeight: FontWeight.w400),),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Fecha viral',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(formatofecha,style: TextStyle(fontWeight: FontWeight.w400),),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(onPressed: () {
                          showNotificacion(gif);
                          Navigator.pop(context);
                        }, child: Text('Atras'), )
                      ],
                    ),
                  )
                ));
              });
            },
          )

      );
    }
    return gifs;
  }

}


