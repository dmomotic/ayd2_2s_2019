import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:my_movie/src/models/actores_model.dart';
import 'package:my_movie/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apiKey = 'df4ba1f873afed562b4f57d943384c46';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  //Creacion del Stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language
    });

    return _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPolulares() async{
    if(_cargando) return[];
    _cargando = true;

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Actor>>getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    final respuesta = await http.get(url);
    //Transforma el body en un mapa
    final decodedData = json.decode(respuesta.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    });

    return _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getSimilares(String peliID) async{
    final url = Uri.https(_url, '3/movie/$peliID/similar', {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    return _procesarRespuesta(url);
  }

  Future<String> getTrailer(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/videos', {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final videoId = decodedData['results'][0]['key'].toString() ?? '';
    return videoId;
  }
}