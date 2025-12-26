import 'package:flutter_movie_search_app/data/data_sources/local/favorite_local_data_source.dart';
import 'package:flutter_movie_search_app/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource _localDataSource;

  FavoriteRepositoryImpl(this._localDataSource);

  @override
  List<int> getFavoriteMovieIds() => _localDataSource.getFavoriteMovieIds();

  @override
  bool isFavorite(int movieId) => _localDataSource.isFavorite(movieId);

  @override
  Future<bool> toggleFavorite(int movieId) async => await _localDataSource.toggleFavorite(movieId);
}