import 'package:flutter/material.dart';
import 'package:strapi_flutter/customisation/text_field.dart';
import 'package:strapi_flutter/view/show_users.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter/view/user.dart';
import 'dart:convert';
import 'dart:async';

class CreateUser extends StatefulWidget {

  final int? id;

  const CreateUser({Key? key, this.id});


  @override
  State<CreateUser> createState() => _CreateUserState();
}

Users users = Users(0, '', '', '');

class _CreateUserState extends State<CreateUser> {

  final TextEditingController _nameController =
      TextEditingController(text: users.name);
  final TextEditingController _emailController =
      TextEditingController(text: users.email);
  final TextEditingController _passwordController =
      TextEditingController(text: users.password);

  @override

  void dispose(){
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future save() async {
    const String url = "http://localhost:65400/api/usuarios";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, String> dataBody = {
      "name": users.name,
      "email": users.email,
      "password": users.name
    };

    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );
    Navigator.pushAndRemoveUntil<void>(context, MaterialPageRoute<void>(builder: (BuildContext context) =>
    const DisplayUsers()) as Route<void>,
        (Route<dynamic> route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: const Text('Create User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 100,
            left: 18,
            right: 18
          ),
          child: Container(
            height: 550,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.indigo[700],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(40),
                child: Text(
                  'Bienvenido',
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
                    controller: _nameController,
                    onChanged: (val){
                      users.name = val;
                    },
                    textDirection: TextDirection.ltr,
                    hinText: 'Name',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.redAccent,
                    ),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    )
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(boxShadow: []),
                  child: Textfield(
                    controller: _emailController,
                    onChanged: (val){
                      users.email = val;
                    },
                    textDirection: TextDirection.ltr,
                    hinText: 'Email',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.redAccent
                    ),
                    icon: const Icon(
                      Icons.email,
                      color: Colors.redAccent,
                    )
                  ),
                ),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(boxShadow: []),
                  child: Textfield(
                    controller: _passwordController,
                    onChanged: (val){
                      users.password = val;
                    },
                    textDirection: TextDirection.ltr,
                    hinText: 'Password',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.redAccent
                    ),
                    icon: const Icon(
                      Icons.password,
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
          ),
        ),
      ),
    );
  }
}
