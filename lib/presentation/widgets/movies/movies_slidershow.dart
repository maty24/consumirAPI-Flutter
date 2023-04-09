import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlidershow extends StatelessWidget {
  //lista de peliculas
  final List<Movie> movies;
  //requiere un parametro movies
  const MoviesSlidershow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    //el sizedbox es para darle un tamaño fijo al widget
    return SizedBox(
      height: 250,
      //le pongo double.infinity para que ocupe todo el ancho
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        //esto es para mostrar la pelicula anterior y la siguiente una breve parte
        viewportFraction: 0.8,
        //estilo del swiper
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
            //para que baje todo el paginador lo que pueda
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
        //el index es el numero de la pelicula
        //se envia la pelicula al widget _Slide
        // => es un arrow function para hacer un return
        itemBuilder: (contex, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  //para que me envie un parametro movie
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
//el boxdecoration es para darle un estilo al widget
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          //el boxshadow es para darle una sombra al widget
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 5),
            blurRadius: 10,
          )
        ]);

    //el padding es para darle un padding al widget
    return Padding(
      //edgeinsets.only es para darle un padding solo a un lado
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          //el cliprrect es para que el widget tenga bordes redondeados
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.backdropPath,
                //el fit es para que la imagen se adapte al widget
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadinProgress) {
                  //si loadinProgress es diferente de null es porque la imagen aun no se cargo
                  if (loadinProgress != null) {
                    return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12));
                  }
                  //si ya se cargo la imagen se muestra la imagen
                  return child;
                },
              ))),
    );
  }
}
