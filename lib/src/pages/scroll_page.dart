import 'package:flutter/material.dart';
import 'package:my_movie/src/pages/home_page.dart';
import 'package:my_movie/src/pages/registro_page.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          RegistroPage(),
          HomePage()
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}