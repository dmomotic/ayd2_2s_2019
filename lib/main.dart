import 'package:flutter/material.dart';
import 'package:my_movie/src/pages/home_page.dart';
import 'package:my_movie/src/pages/registro_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Movie',

      //Ruta inicial
      initialRoute: 'registro',

      //Rutas de nuestra aplicacion
      routes: {
        'registro' : (BuildContext context) => RegistroPage(),
        'home'     : (BuildContext context) => HomePage()
      },

      //Tema aplicacion
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),

    );
  }
}