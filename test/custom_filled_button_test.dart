import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_movie/src/widgets/custom_filled_button.dart';

void main(){
  Widget makeTesteableWidget({Widget child}){
    return MaterialApp(
      home: child
    );
  }

  testWidgets('It test the right build of the custom filled button', (WidgetTester tester) async{

    await tester.pumpWidget(
      makeTesteableWidget(
        child: CustomFilledButtom(
          text: "Registrarse"    
        )
      ));

    final texto = find.text("Registrarse");

    expect(texto, findsOneWidget);

  });
}