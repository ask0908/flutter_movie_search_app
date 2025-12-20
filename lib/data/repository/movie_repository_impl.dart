import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_movie_search_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_search_app/data/data_sources/remote/movie_api_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _apiService;

  MovieRepositoryImpl(this._apiService);

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    try {
      final response = await _apiService.getNowPlaying(page: page);
      return response.results.map((model) => model.toEntity()).toList();
    } catch (e) {
      debugPrint('[Repository Error] getNowPlaying : $e');
      rethrow;
    }
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async {
    try {
      final response = await _apiService.getPopular(page: page);
      return response.results.map((model) => model.toEntity()).toList();
    } catch (e) {
      debugPrint('[Repository Error] getPopular : $e');
      rethrow;
    }
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    try {
      final response = await _apiService.getTopRated(page: page);
      return response.results.map((model) => model.toEntity()).toList();
    } catch (e) {
      debugPrint('[Repository Error] getTopRated : $e');
      rethrow;
    }
  }

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
    try {
      final response = await _apiService.getUpcoming(page: page);
      return response.results.map((model) => model.toEntity()).toList();
    } catch (e) {
      debugPrint('[Repository Error] getUpcoming : $e');
      rethrow;
    }
  }

  @override
  Future<List<MovieEntity>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _apiService.searchMovies(
        query: query,
        page: page,
      );
      return response.results.map((model) => model.toEntity()).toList();
    } catch (e) {
      debugPrint('[Repository Error] searchMovies : $e');
      rethrow;
    }
  }

  @override
  Future<MovieEntity> getMovieDetail(int movieId) async {
    try {
      final detailModel = await _apiService.getMovieDetail(movieId: movieId);
      return detailModel.toEntity();
    } on DioException catch (e) {
      // Dio 관련 에러 - 네트워크, 타임아웃 등
      debugPrint(
          '[Repository Error] getMovieDetail DioException : ${e.message}');
      if (e.response?.statusCode == 404) {
        throw Exception('영화를 찾을 수 없습니다. id : $movieId)');
      }
      rethrow;
    } catch (e) {
      // 기타 에러
      debugPrint('[Repository Error] getMovieDetail : $e');
      rethrow;
    }
  }
}
