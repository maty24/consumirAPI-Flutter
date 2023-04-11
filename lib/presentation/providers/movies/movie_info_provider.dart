import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
//aca estoy llamando al provider que esta arriba
  final movieRespository = ref.watch(movieRepositoryProvider);
  //estoy llamando el provider
  return MovieMapNotifier(getMovie: movieRespository.getMovieById);
});

/*
asi va a funcionar el state
esto es el state
'4324':mievue()
 */

//esto es un callback que es un future de movie y recibe un string, va a ser una funcion que va a recibir un string y va a devolver un future de movie
typedef GetMovieCallback = Future<Movie> Function(String movieId);

//esto es un map que es un string y apunto a la movie
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    print('realizando peticon http');
//getmovie es una funcion que recibe un string y devuelve un future de movie
    final movie = await getMovie(movieId);

//clono el state y le agrego el movieId
    state = {...state, movieId: movie};
  }
}
