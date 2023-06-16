import 'package:cinemapedia/presentation/view/views.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) {
        //el child son las rutas que pongo y estas rutas viene un widget
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                //le pongo :id para que sea dinamico y reciba el id de la pelicula
                path: 'movie/:id',
                name: MovieScreen.name,
                builder: (context, state) {
                  //si no hay id, le pongo no-id, busca el id en los parametros
                  final movieId = state.params['id'] ?? 'no-id';
                  //le paso el id a la pantalla de pelicula
                  return MovieScreen(movieId: movieId);
                },
              ),
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ]),

  /* routas padre/hijo
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(childView: FavoritesView()),
      //esto es para las rutas hijas
      routes: [
       //ruta hija que no es necesario poner el / al principio
        GoRoute(
          //le pongo :id para que sea dinamico y reciba el id de la pelicula
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            //si no hay id, le pongo no-id, busca el id en los parametros
            final movieId = state.params['id'] ?? 'no-id';
            //le paso el id a la pantalla de pelicula
            return MovieScreen(movieId: movieId);
          },
        ),
      ]),*/
]);
