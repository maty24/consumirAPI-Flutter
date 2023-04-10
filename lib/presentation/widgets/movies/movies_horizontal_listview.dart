import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  //el voidcallback es una funcion que no recibe nada y no devuelve nada
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  //esto es para que sepa cuando se esta moviendo el scroll
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //el widget es el widget que se esta mostrando
      if (widget.loadNextPage == null) return;

//si el escroll esta en el final de la pantalla - 200 hace la funcion
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
//cuando me salgo de la pantalla se destruye el scrollcontroller
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          //solo se muestra si el titulo o el subtitulo no es nulo
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),

          Expanded(
            //se ocupa el listview.builder porque es mas eficiente que el listview
            child: ListView.builder(
              //esta pendiente del scroll
              controller: scrollController,
              itemCount: widget.movies.length,
              //esta es la direccion del scroll que puede ser horizontal o vertical pero es horizontal
              scrollDirection: Axis.horizontal,
              //esto es para que se vea igual en ios y android
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                //el index es el numero de la pelicula que se esta mostrando
                return _Slide(movie: widget.movies[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
//busco el tiulo en el tema de la aplicacion
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        //le digo que todo sus hijos se alineen a la izquierda
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //este widget es la imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                //el fit es para que la imagen se ajuste al tamaño del contenedor
                fit: BoxFit.cover,
                width: 150,
                //el context es el contexto de la aplicacion y el child es la imagen y el loadingProgress es el progreso de la imagen
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  //el gesture detector es para que cuando se toque la imagen se haga algo
                  return GestureDetector(
                    //el on tap es para que cuando se toque la imagen se haga algo
                    onTap: ( ) => context.push('movie/${movie.id}'),
                    //el child es la imagen que se retorna
                    child: FadeIn(child: child),
                  );
                  //retorrno el child que es la imagen
                  
                },
              ),
            ),
          ),

          //titlo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              //estas son las lineas que se muestran maximo
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleSmall,
            ),
          ),

          //rating

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text('${movie.voteAverage}',
                    style: textStyles.bodyMedium
                        //el copywith es para copiar el estilo del texto y cambiarle el color
                        ?.copyWith(color: Colors.yellow.shade800)),
                //el spacer es para que el texto se quede pegado a la izquierda y el boton a la derecha
                const Spacer(),
                //esto es para que se vea el numero de la popularidad y humanformat es para que se vea como 1.2k
                Text(HumanFormats.number(movie.popularity),
                    style: textStyles.bodySmall),
                //Text('${movie.popularity}', style: textStyles.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      //el margin es para que el texto no este pegado a los bordes
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (title != null)
            //le pongo title! porque el titulo no puede ser nulo
            Text(title!, style: titleStyle),
          //el spacer es para que el texto se quede pegado a la izquierda y el boton a la derecha
          const Spacer(),

          if (subtitle != null)
            FilledButton.tonal(
                onPressed: () {},
                child: Text(subtitle!),
                style: const ButtonStyle(
                  //el visual density es para que el boton no se vea tan grande
                  visualDensity: VisualDensity.compact,
                ))
        ],
      ),
    );
  }
}
