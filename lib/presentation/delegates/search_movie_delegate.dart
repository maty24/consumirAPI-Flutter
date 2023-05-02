import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

//estoy creado un tipo de dato que es una funcion que recibe un string y devuelve un future de lista de peliculas
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate(this.searchMovies);

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
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      //el future es la funcion que recibe un string y devuelve un future de lista de peliculas, el query es el texto que se esta escribiendo en la barra de busqueda
      future: searchMovies(query),
      initialData: const [],
      builder: (context, snapshot) {
        //el snapshot es el resultado de la busqueda
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            //estoy obteniendo la pelicula de la lista de peliculas
            final movie = movies[index];
            return ListTile(title: Text(movie.title));
          },
        );
      },
    );
  }
}
