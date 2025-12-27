import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

abstract class FavoriteRepository {
  /// 좋아요한 영화 ID 목록
  List<int> getFavoriteMovieIds();

  /// 좋아요한 영화 전체 정보 목록
  List<MovieEntity> getFavoriteMovies();

  /// 좋아요 추가
  Future<bool> addFavorite(MovieEntity movie);

  /// 좋아요 제거
  Future<bool> removeFavorite(int movieId);

  /// 좋아요 토글
  Future<bool> toggleFavorite(MovieEntity movie);
}