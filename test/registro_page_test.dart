import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_movie/src/pages/registro_page.dart';

void main(){

  Widget makeTesteableWidget({Widget child}){
    return MaterialApp(
      home: child
    );
  }

  testWidgets('It should show the main widgets of the register page', (WidgetTester tester) async{
    //Creamos el widget
    await tester.pumpWidget(makeTesteableWidget(child: RegistroPage()));

    //Creacion de finders
    final textoRegistrarse = find.text("REGISTRARSE");
    final textoPassword = find.text("PASSWORD");
    final textoEmail = find.text("EMAIL");

    //Realizamos match para verificar el correcto funcionamiento
    expect(textoRegistrarse, findsOneWidget);
    expect(textoPassword, findsOneWidget);
    expect(textoEmail, findsOneWidget);
  });
}