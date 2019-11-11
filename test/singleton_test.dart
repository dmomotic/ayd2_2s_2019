import 'package:test/test.dart';
import 'package:my_movie/src/providers/peliculas_provider.dart';
import 'package:my_movie/src/providers/usuario_provider.dart';

void main(){
  test('Both instances should be the same', (){
    final instance1 = PeliculasProvider();
    final instance2 = PeliculasProvider();

    expect(identical(instance1, instance2), true);
  });

  test('Both instances should be distinct', (){
    final instance1 = UsuarioProvider();
    final instance2 = UsuarioProvider();

    expect(identical(instance1, instance2), false);
  });
}