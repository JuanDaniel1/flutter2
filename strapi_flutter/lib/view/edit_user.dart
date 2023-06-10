
import 'package:flutter/material.dart';
import 'package:strapi_flutter/customisation/text_field.dart';
import 'package:strapi_flutter/view/add_user.dart';
import 'package:strapi_flutter/view/show_users.dart';
import 'package:strapi_flutter/view/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditUser extends StatefulWidget {

  final users;
  const EditUser({super.key, required this.users});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  void editUser({
    required Users users,
    required String email,
    required String password,
    required String name
}) async {
    @override

    const String url = "http://localhost:65400/api/usuarios/";

    final Map<String, String> dataHeader = {
      'Access-Control-Allow-Methods': '[GET, POST, PUT, DELETE, HEAD, OPTIONS]',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Map<String, dynamic> dataBody = {
      "name": name,
      "email": email,
      "password": password
    };
    final response = await http.put(
      Uri.parse(url + users.id.toString()),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => const DisplayUsers()
      ), (Route<dynamic> route) => false);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
    TextEditingController(text: widget.users.name);
    TextEditingController emailController =
    TextEditingController(text: widget.users.email);
    TextEditingController passwordController =
    TextEditingController(text: widget.users.password);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: const Text('Edit User'),
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
                const Padding(padding: EdgeInsets.all(40),
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
                    hinText: 'Name',
                    hintStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.redAccent
                  ),
                    icon: const Icon(
                      Icons.person,
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
                    controller: emailController,
                    onChanged: (val) {

                      emailController.value =
                          emailController.value.copyWith(text: val);
                      // emailController.value =
                      // emailController.value.copyWith(text: val);
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
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(boxShadow: []),
                  child: Textfield(
                    controller: passwordController,
                    onChanged: (val) {
                      passwordController.value =
                          passwordController.value.copyWith(text: val);
                      // passwordController.value =
                      //passwordController.value.copyWith(text: val);
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
                          users: widget.users,
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text  
                      );
                      
                    },
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
