import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

abstract class MovieRepository {
  /// 현재 상영중인 영화 목록
  Future<List<MovieEntity>> getNowPlaying({int page = 1});

  /// 인기 영화 목록
  Future<List<MovieEntity>> getPopular({int page = 1});

  /// 평점 높은 영화 목록
  Future<List<MovieEntity>> getTopRated({int page = 1});

  /// 개봉 예정 영화 목록
  Future<List<MovieEntity>> getUpcoming({int page = 1});

  /// 영화 검색
  Future<List<MovieEntity>> searchMovies({
    required String query,
    int page = 1,
  });

  /// 영화 상세 정보
  Future<MovieEntity> getMovieDetail(int movieId);
}