
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
  if(value.isEmpty || value.length < 4)
    return "*Longitud minima de 4";
  else
    return null;
}