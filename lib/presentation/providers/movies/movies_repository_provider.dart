import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

//repositorio es inmutable y solo es de lectura
final movieRepositoryProvider = Provider((ref) {
  //retorna una instancia de la implementacion del repositorio
  //MoviedbDatasource es la implementacion de la fuente de datos donde se obtienen los datos
  return MovieRepositoryImpl(MoviedbDatasource());
});
