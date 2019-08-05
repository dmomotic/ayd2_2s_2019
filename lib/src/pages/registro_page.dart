import 'package:flutter/material.dart';

import 'package:my_movie/src/widgets/custom_text_field.dart';

class RegistroPage extends StatefulWidget {

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;
  String errorMsg = "";

  Color primaryColor = Colors.deepOrangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearFormulario()
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color> [
            Colors.orangeAccent,
            Colors.deepOrange
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );


    return Stack(
      children: <Widget>[
        fondo,
        Positioned( top: 90.0, left: 15.0, child: circulo ),
        Positioned( top: -40.0, right: -30.0, child: circulo ),
        Positioned( top: 200.0, right: 20.0, child: circulo ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon( Icons.movie_filter, color: Colors.white, size: 100.0 ),
              SizedBox( height: 10.0, width: double.infinity ),
              Text('My Movie App', style: TextStyle( color: Colors.white, fontSize: 25.0 ))
            ],
          ),
        )

      ],
    );
  }

  Widget _crearFormulario(){
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric( vertical: 50.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    onSaved: (input) => _email = input,
                    validator: emailValidator,
                    icon: Icon(Icons.email),
                    hint: "EMAIL",
                  ),
                  Divider(height: 25.0),
                  CustomTextField(
                    icon: Icon(Icons.lock),
                    obsecure: true,
                    onSaved: (input) => _password = input,
                    validator: (input) => input.isEmpty ? "*Campo obligatorio" : null,
                    hint: "PASSWORD",
                  ),
                  Divider(height: 50.0),
                  Container(
                    child: filledButton(
                      "LOGIN",
                      Colors.white,
                      primaryColor,
                      primaryColor,
                      Colors.white,
                      null
                    ),
                    height: 50.0,
                    width: 0.4 * size.width,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filledButton(String text, Color splashColor, Color highlightColor, Color fillColor, Color textColor, void function()) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
      ),
      onPressed: () {
        function();
      },
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

}