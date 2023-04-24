import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

import '../../domain/datasources/actors_datasource.dart';


//el provider pueda obtener la informacion de la api y funciona como puente
class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDataSource dataSource;

  ActorRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
}
