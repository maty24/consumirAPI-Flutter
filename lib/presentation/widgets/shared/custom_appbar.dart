import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../delegates/search_movie_delegate.dart';
import '../../providers/movies/movies_repository_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    //busco el color en el tema global
    final colors = Theme.of(context).colorScheme;
    //el titlemedium es un estilo que esta en el tema global
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    //el safearea es para que no se vea el notch de los iphone
    return SafeArea(
      child: Padding(
          //el edgeinsets es para que el texto no este pegado a los bordes  y symmetric es para que sea igual en los dos lados
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            //el double.infinity es para que el widget ocupe todo el ancho
            width: double.infinity,
            //el row es para que el icono y el texto esten en la misma linea
            child: Row(children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
              //el spacer es para que el icono se ponga al final y el texto se ponga al principio, pega todo al final
              const Spacer(),
              IconButton(
                  onPressed: () {
                    //estoy buscando el repositorio de peliculas y me retorna el repositorio
                    final movieRespository = ref.read(movieRepositoryProvider);

                    showSearch<Movie?>(
                        //el context es el contexto de la aplicacion
                        context: context,
                        //el que se encarga de buscar
                        delegate: SearchMovieDelegate(
                            //estoy mandando la referencia de la funcion searchMovies
                            movieRespository.searchMovies)
                            ).then((movie){
                              if(movie == null) return;
                              context.push('/movie/${movie.id}');
                            });
                  },
                  icon: const Icon(Icons.search))
            ]),
          )),
    );
  }
}
