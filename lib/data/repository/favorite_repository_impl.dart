import 'package:flutter_movie_search_app/data/data_sources/local/favorite_local_data_source.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_movie_search_app/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource _localDataSource;

  FavoriteRepositoryImpl(this._localDataSource);

  @override
  List<int> getFavoriteMovieIds() => _localDataSource.getFavoriteMovieIds();

  @override
  List<MovieEntity> getFavoriteMovies() => _localDataSource.getFavoriteMovies();

  @override
  Future<bool> addFavorite(MovieEntity movie) async =>
      await _localDataSource.addFavorite(movie);

  @override
  Future<bool> removeFavorite(int movieId) async =>
      await _localDataSource.removeFavorite(movieId);

  @override
  Future<bool> toggleFavorite(MovieEntity movie) async =>
      await _localDataSource.toggleFavorite(movie);
}