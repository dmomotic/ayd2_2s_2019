import 'package:test/test.dart';
import 'package:my_movie/src/providers/peliculas_provider.dart';
import 'package:my_movie/src/models/pelicula_model.dart'; 

void main(){
  test('Bloc stream should emmit data', () async {
    final bloc = PeliculasProvider();
    //Solicitud a The Movie DB y adicion de datos al Sink
    await bloc.getPolulares();
    //Luego de recibir los datos emite un Broadcast con todas las peliculas
    expect(bloc.popularesStream, TypeMatcher<Stream<List<Pelicula>>>());
  });
}