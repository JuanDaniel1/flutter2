import 'package:flutter/material.dart';
import 'package:giffv2/notificacion/notificacion.dart';
import 'package:http/http.dart' as http;
import 'package:giffv2/models/gif_app.dart';
import 'dart:convert';

import 'package:intl/intl.dart';



class  MobileScaffold extends StatefulWidget  {
  const MobileScaffold({Key? key}) : super(key: key);


  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
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

      //Llamamos los data que simbolizan cada gift y luego añadimos las propiedades que necesitemos de este gift, gracias al formato JSON
      for(var item in jsonData['data']){
        gifs.add(Gif(item['title'], item['images']['downsized']['url'],item['id'],item['trending_datetime'],item['username']));
      }

      //En consola podremos visualizar el nombre del gift y el url del numero 0
      //print (jsonData);
      //print (jsonData['data']);
      //print (jsonData['data'][0]);
      //print (jsonData['data'][0]['type']);
      print ('${gifs[0].name} ${gifs[0].url}');

    }else{
//Si no imprime ninguna data, entonces devolvera error
      throw Exception('Fallo la conexion');
    }
    //Por ultimo va a retornar todos los datos de gifts agregados anteriormente
    return gifs;
  }
  //Esta funcion es por defecto lo primero que realizara, definiendo una variable para la funcion _getGifs()
  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGifs();
  }
  //Definimos las listas para la cantidad de gifts y sus rangos, por otro lado las variables dinamicas que iran cambiando dependiendo de lo que el usuario escoja
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
//Esta parte se realiza el listado de los numeros que se vera en la parte superior
              DropdownButtonFormField(
                hint: Text('Seleccione la cantidad'),
                items: list_contador.map((selected){
                  //Se visualizara la cantidad actual seleccionada en el text y se asigna selected como value para definirlo
                  return DropdownMenuItem(
                    child: Text(selected),
                    value: selected,
                  );
                  //Lo convertimos en formato lista
                }).toList(),
                onChanged: (value){
                  setState(() =>
                  selected = value);
                  print(selected);
                  _listadoGifs = _getGifs();
                },
              ),
              //Se hace lo mismo con rango
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
              //El futuro se encargara de recibir nuevos datos a partir de la pagina giphy, _listadoGifs que es futuro anteriormente y snapshot confirma si ya recibio data en listadogifs
              Expanded(child: FutureBuilder(
                  future: _listadoGifs,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      //Gridview.count se encargara de repartir grillas por fila gracias a crossAxisCount
                      return GridView.count(
                        crossAxisCount: 2,
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
  //Se crea una lista con los datos almacenados para cargar los gifs, tambien se asigna el formato de fecha
  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      String date = gif.trending_datetime;
      final parcedate = DateTime.parse(date);
      final formatofecha = DateFormat('dd/MMMM/yyyy').format(parcedate);
      gifs.add(
        //GestureDetector se encargara de crear una funcion al presionar lo que tiene dentro
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
                //Se crea el modal para asignar el nombre del creador, id del gif y fecha viral
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text(gif.name),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.network(gif.url, fit: BoxFit.fill,),
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





