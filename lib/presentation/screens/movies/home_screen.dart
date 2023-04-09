import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movies/initial_loading_provider.dart';
import '../../widgets/shared/full_screen_loader.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      //barra de navegacion inferior
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

////////////////////////////////////////////////////////////////
//BODY DE SCAFFOLD
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  //es la clase de homeview que se encarga de crear el estado
  _HomeViewState createState() => _HomeViewState();
}

////////////////////////////////////////////////////////////////

class _HomeViewState extends ConsumerState<_HomeView> {
//los statesfullwidget tienen un initState que se ejecuta cuando se crea el widget
  @override
  void initState() {
    super.initState();
    //read porque estoy en un metodo de un statefullwidget
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    //mostramos las peliculas que se estan reproduciendo
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlidershowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //el customscrollview es para que se pueda hacer scroll en la pantalla, es mas lindo
    return CustomScrollView(
      //se crea una lista de slivers
      slivers: [
        //se crea un sliverappbar que es la barra de arriba
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        //se crea un sliverlist que es una lista de widgets
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                //  const CustomAppbar(),
                //se pasa la lista de peliculas
                MoviesSlidershow(movies: slideShowMovies),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 10',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subtitle: 'En este mes',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  subtitle: 'Si',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor valoradas',
                  subtitle: 'Historico',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),

                const SizedBox(height: 100),
                //el expanded es para que el listview ocupe todo el espacio y tiene vertical scroll por defecto
                //Expanded(
              ],
            );
          },

          //para que sepa cuantos widgets va a crear en este caso 1
          childCount: 1,
        ))
      ],
    );
  }
}
