import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_search_app/data/data_sources/remote/dio_client.dart';
import 'package:flutter_movie_search_app/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_movie_search_app/data/repository/movie_repository_impl.dart';
import 'package:flutter_movie_search_app/domain/repository/movie_repository.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

/// Dio 클라이언트 Provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Movie API 서비스 Provider
final movieApiServiceProvider = Provider<MovieApiService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MovieApiService(dioClient.dio);
});

/// Movie Repository Provider (인터페이스 타입으로 제공)
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final apiService = ref.watch(movieApiServiceProvider);
  return MovieRepositoryImpl(apiService);
});

/// 현재 상영중 영화 Provider
final nowPlayingProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return await repository.getNowPlaying();
});

/// 인기 영화 Provider
final popularMoviesProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return await repository.getPopular();
});

/// 평점 높은 영화 Provider
final topRatedMoviesProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return await repository.getTopRated();
});

/// 개봉 예정 영화 Provider
final upcomingMoviesProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return await repository.getUpcoming();
});

/// 영화 상세 정보 Provider
final movieDetailProvider = FutureProvider.family<MovieEntity, int>((ref, movieId) async {
  final repository = ref.watch(movieRepositoryProvider);
  return await repository.getMovieDetail(movieId);
});
