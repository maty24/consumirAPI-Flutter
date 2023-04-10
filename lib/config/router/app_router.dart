import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    //le pongo :id para que sea dinamico y reciba el id de la pelicula
    path: '/movie:id',
    name: MovieScreen.name,
    builder: (context, state) {
      //si no hay id, le pongo no-id, busca el id en los parametros
      final movieId = state.params['id'] ?? 'no-id';
      //le paso el id a la pantalla de pelicula
      return MovieScreen(movieId: movieId);
    },
  ),
]);
