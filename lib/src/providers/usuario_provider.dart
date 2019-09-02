import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider{

  String _firebaseToken = 'AIzaSyB9sNhT_IufSG0uCCLRZTS0Q_Pxtn5Oq-E';

  Future<Map<String,dynamic>> nuevoUsuario(String email, String password) async{
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return decodedResp.containsKey('idToken')
            ? {'ok': true, 'message': 'Cuenta creada correctamente'}
            : {'ok': false, 'message': decodedResp['error']['message']};
  }

  Future<Map<String,dynamic>> login(String email, String password) async{
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return decodedResp.containsKey('idToken')
            ? {'ok': true, 'message': 'Cuenta creada correctamente'}
            : {'ok': false, 'message': decodedResp['error']['message']};
  }

}