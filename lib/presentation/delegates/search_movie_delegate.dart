import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

//estoy creado un tipo de dato que es una funcion que recibe un string y devuelve un future de lista de peliculas
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  //para multiples listener
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies});

  //para limpiar los streams
  void clearStreams() {
    debounceMovies.close();
  }

  //muy util el devounce
  void _onQueryChanged(String query) {
    //si timer tiene un valor y esta activo encontes lo limpio y no seguie mas, cuando deja de escribir y hace una peticion
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(microseconds: 500), () async {
      if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      }
      final movies = await searchMovies(query);
      //hace la peticion y lo que puse en la barra de busqueda
      debounceMovies.add(movies);
    });
  }

//para cambiar el texto de la barra de busqueda
  @override
  String get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //si el query no esta vacio, entonces me devuelve un icono de limpiar
      //if (query.isNotEmpty)
      FadeIn(
        //si el query no esta vacio, entonces me devuelve un icono de limpiar
        animate: query.isNotEmpty,
        child: IconButton(
            //el query es el texto que se esta escribiendo en la barra de busqueda
            onPressed: () => query = '',
            icon: const Icon(Icons.clear_rounded)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        //el precio de cerrar la busqueda es null porque no quiero que me devuelva nada
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

//esto es para hacer las peticiones de las busquedas
  @override
  Widget buildSuggestions(BuildContext context) {
    //cada vez que toclo una tecla de ejecuta esta funcion
    _onQueryChanged(query);
    return StreamBuilder(
      //el future es la funcion que recibe un string y devuelve un future de lista de peliculas, el query es el texto que se esta escribiendo en la barra de busqueda
      //future: searchMovies(query),
      stream: debounceMovies.stream,
      initialData: const [],
      builder: (context, snapshot) {
        //el snapshot es el resultado de la busqueda
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              //le mando la funcion close que esta global en el delagate
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              }),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      //que ponga maximo 100 carecteres en pantalla
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
