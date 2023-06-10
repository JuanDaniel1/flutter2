import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter/view/user.dart';
import 'package:strapi_flutter/view/user_detail.dart';
import 'dart:convert';

class DisplayUsers extends StatefulWidget {
  const DisplayUsers({Key? key}) : super(key: key);

  @override
  State<DisplayUsers> createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers> {

  List<Users>user = [];

  Future<List<Users>> getAll() async {
    const String url = 'http://localhost:65400/api/usuarios/';

    var response = await http.get(
      Uri.parse(url)
    );

    if(response.statusCode==200){
      user.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable usuariosData = decodedData.values;

    for (var item in usuariosData.elementAt(0)) {
      user.add(Users(
        item['id'],
        item['attributes']['name'],
        item['attributes']['email'],
        item['attributes']['password'],
      ));
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Users'),
        elevation: 0.0,
        backgroundColor: Colors.indigo[700],
      ),
      body: FutureBuilder(
        future: getAll(),
        builder: (context, AsyncSnapshot<List<Users>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) =>
            InkWell(
              child: ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].email),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_)=>UserDetails(
                      users: snapshot.data![index],
                    ))
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
