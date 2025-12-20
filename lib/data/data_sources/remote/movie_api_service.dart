import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_movie_search_app/core/constants/api_constants.dart';
import 'package:flutter_movie_search_app/data/models/movie_response.dart';
import 'package:flutter_movie_search_app/data/models/movie_detail_model.dart';  // 👈 추가

part 'movie_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  /// 현재 상영중인 영화 리스트
  @GET('/movie/now_playing')
  Future<MovieResponse> getNowPlaying({
    @Query('language') String language = ApiConstants.language,
    @Query('page') int page = 1,
  });

  /// 인기 영화 리스트
  @GET('/movie/popular')
  Future<MovieResponse> getPopular({
    @Query('language') String language = ApiConstants.language,
    @Query('page') int page = 1,
  });

  /// 평점 높은 영화 리스트
  @GET('/movie/top_rated')
  Future<MovieResponse> getTopRated({
    @Query('language') String language = ApiConstants.language,
    @Query('page') int page = 1,
  });

  /// 개봉 예정 영화 리스트
  @GET('/movie/upcoming')
  Future<MovieResponse> getUpcoming({
    @Query('language') String language = ApiConstants.language,
    @Query('page') int page = 1,
  });

  /// 영화 검색
  @GET('/search/movie')
  Future<MovieResponse> searchMovies({
    @Query('query') required String query,
    @Query('language') String language = ApiConstants.language,
    @Query('page') int page = 1,
    @Query('include_adult') bool includeAdult = ApiConstants.includeAdult,
  });

  /// 영화 상세 정보
  @GET('/movie/{movie_id}')
  Future<MovieDetailModel> getMovieDetail({
    @Path('movie_id') required int movieId,
    @Query('language') String language = ApiConstants.language,
  });
}
