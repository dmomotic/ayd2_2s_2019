import 'package:flutter/material.dart';
//Usuario Provider
import 'package:my_movie/src/providers/usuario_provider.dart';
//Utilidades
import 'package:my_movie/src/utils/utils.dart' as utils;
//Widgets personalizados
import 'package:my_movie/src/widgets/custom_filled_button.dart';
import 'package:my_movie/src/widgets/custom_text_field.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  //Para manejar los validators en el formualrio
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Variables donde voy a capturar lo ingresado por el usuario
  String _email;
  String _password;

  //Color principal 
  Color primaryColor = Colors.deepOrangeAccent;

  //Variable que contiene metodos de login y registro
  UsuarioProvider _usuarioProvider = new UsuarioProvider();

  bool _consultando = false;

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
            Colors.deepPurple,
            Colors.deepPurple
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
            padding: EdgeInsets.symmetric( vertical: 50.0),
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
            child: _crearForm(size),
          ),
        ],
      ),
    );
  }

  Widget _crearForm(Size size){
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          _crearEmailInput(),
          _crearPasswordInput(),
          _crearLoginButtom()
        ],
      ),
    );
  }

  Widget _crearEmailInput(){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: CustomTextField(
        icon: Icon(Icons.email),
        onSaved: (input) => _email = input,
        validator: utils.emailValidator,
        hint: "EMAIL",
      ),
    );
  }

  Widget _crearPasswordInput(){
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: CustomTextField(
        icon: Icon(Icons.lock),
        obsecure: true,
        onSaved: (input) => _password = input,
        validator: utils.passwordValidator,
        hint: "PASSWORD",
      ),
    );
  }

  Widget _crearLoginButtom(){
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        child: CustomFilledButtom(
          text: "REGISTRARSE",
          splashColor: Colors.white,
          highlightColor: primaryColor,
          fillColor: primaryColor,
          textColor: Colors.white,
          onPressed: _consultando ? null :_submitDataForm,
        ),
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }

  void _submitDataForm() async{
    if(!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    
    //Codigo si todo esta bien
    setState(() {
      _consultando = true;
    });
    Map respuesta = await _usuarioProvider.nuevoUsuario(_email, _password);
    
    if(respuesta['ok']){
      utils.mostrarAlerta(context, respuesta['message'], 'La cuenta fue creada');
      //Acceso a la pagina del home
      //Navigator.pushReplacementNamed(context, 'home');
    }
    else{
      utils.mostrarAlerta(context, respuesta['message'], 'Ocurrio un error al crear la cuenta');
    }

    setState(() {
      _consultando=false;
    });
  }

}