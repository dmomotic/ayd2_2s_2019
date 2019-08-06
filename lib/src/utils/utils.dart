import 'package:flutter/material.dart';

//Funcion utilizada para validar el correo electronico
String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) return '*Campo obligatorio';
  if (!regex.hasMatch(value))
    return '*Ingresa un email valido';
  else
    return null;
}

//Funcion utilizada para validar la contraseña
String passwordValidator(String value){
  if(value.isEmpty || value.length < 6)
    return "*Longitud minima de 6";
  else
    return null;
}

//Funcion utilizada para mostrar alertas
void mostrarAlerta(BuildContext context, String titulo, String mensaje){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop()
          )
        ],
      );
    }
  );
}