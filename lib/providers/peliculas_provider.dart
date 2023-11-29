import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/keys.dart';
import 'package:peliculas/models/pelicula_model.dart';

class PeliculasProvider {
  final String _apikey = api_key;
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  final List<Pelicula> _populares = [];
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});
    return await procesarRespuesta(url);
  }

  Future<List<Pelicula>> procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = ListaPeliculas.fromJsonList(decodeData['results']);
    popularesSink(peliculas.items);
    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = procesarRespuesta(url);
    _populares.addAll(_populares);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }
}
