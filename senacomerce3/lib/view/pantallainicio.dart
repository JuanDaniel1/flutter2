
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:senacomerce3/view/splash.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});


  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[800],
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: Container(
                  padding: EdgeInsets.only(right: 5, left: 5, top: 50, bottom: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                    )
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child:Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Los mejores productos", style: TextStyle(
                      color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        letterSpacing: 5,
                      ),),
                    ),
                  ),
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset("assets/logo.png", width: MediaQuery.of(context).size.width/2,
                      height: 300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:100),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(13.0),
                      ),child: Icon(
                          Icons.chevron_right,
                          color: Colors.lightGreen[800],
                        ),

                      onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Splash()));
                      },
                  ),
                ],
            )
          ],
        ),
      ),
    );
  }
}
