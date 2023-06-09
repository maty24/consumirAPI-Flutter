import 'package:cinemapedia/domain/entities/movie.dart';

//estoy ejecutando el metodo getNowPlaying de la clase MoviesDatasource y el getPopular de la clase MoviedbDatasource
abstract class MoviesDatasource {
  //para definir 
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

//defino el data source, estas son las funciones que debe tener el moviesDatasource
  Future<Movie> getMovieById(String id);
}
