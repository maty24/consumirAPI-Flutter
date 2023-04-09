import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

//le digo que es una lista de peliculas
final moviesSlidershowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  //si esta vacia retorna un arreglo vacio
  if (nowPlayingMovies.isEmpty) return [];
  //si no retorna un arreglo con las primeras 6 peliculas
  return nowPlayingMovies.sublist(0, 6);
});
