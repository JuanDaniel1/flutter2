
import 'package:flutter/material.dart';
import 'package:strapi_flutter/view/edit_user.dart';
import 'package:strapi_flutter/view/show_users.dart';
import 'package:strapi_flutter/view/user.dart';
import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  final Users users;
  const UserDetails({Key? key, required this.users}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    
    void deleteUser() async{
      const String url = "http://localhost:65400/api/usuarios/";
      
      await http.delete(
        Uri.parse(url + widget.users.id.toString())
      );
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => const DisplayUsers()
      ),
          (Route<dynamic> route) => false
        
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Details'),
        elevation: 0.0,
        backgroundColor: Colors.indigo[700],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 32
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo[700],
                child: const Center(
                  child: Text(
                    'Details',
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 32
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.users.id}'),
                      const SizedBox(height: 10,),
                      Text(widget.users.name),
                      const SizedBox(height: 10,),
                      Text(widget.users.email),
                      const SizedBox(height: 10,),
                      Text(widget.users.password),

                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => EditUser(users: widget.users,)));
                    }, child: const Text('Edit'),
                  ),
                  TextButton(onPressed: (){
                    deleteUser();
                  },child: const Text('Delete'),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
