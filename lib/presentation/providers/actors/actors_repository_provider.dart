import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/datasources/actor_moviedb_datasource.dart';
import '../../../infrastructure/repositories/actor_repository_impl.dart';

// Este repositorio es inmutable, por lo que no se puede cambiar y es solo para leer
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
