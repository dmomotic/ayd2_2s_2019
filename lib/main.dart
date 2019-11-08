import 'package:flutter/material.dart';
import 'package:my_movie/src/pages/home_page.dart';
import 'package:my_movie/src/pages/login_page.dart';
import 'package:my_movie/src/pages/pelicula_detalle_page.dart';
import 'package:my_movie/src/pages/registro_page.dart';
import 'package:my_movie/src/pages/scroll_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PRUEBA CODEMAGIC',

      //Ruta inicial
      initialRoute: 'home',

      //Rutas de nuestra aplicacion
      routes: {
        'registro' : (BuildContext context) => RegistroPage(),
        'home'     : (BuildContext context) => HomePage(),
        'scroll'   : (BuildContext context) => ScrollPage(),
        'login'    : (BuildContext context) => LoginPage(),
        'detalle'  : (BuildContext context) => PeliculaDetalle()
      },

      //Tema aplicacion
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),

    );
  }
}