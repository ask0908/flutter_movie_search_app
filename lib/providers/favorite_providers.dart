import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_movie_search_app/data/data_sources/local/favorite_local_data_source.dart';
import 'package:flutter_movie_search_app/data/repository/favorite_repository_impl.dart';
import 'package:flutter_movie_search_app/domain/repository/favorite_repository.dart';

// 쉐어드 provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences는 main.dart에서 초기화돼야 함');
});

/// FavoriteLocalDataSource provider
final favoriteLocalDataSourceProvider =
    Provider<FavoriteLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return FavoriteLocalDataSource(prefs);
});

/// FavoriteRepository provider
final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final localDataSource = ref.watch(favoriteLocalDataSourceProvider);
  return FavoriteRepositoryImpl(localDataSource);
});

/// 좋아요 상태 관리
class FavoriteNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() {
    final repository = ref.watch(favoriteRepositoryProvider);
    return repository.getFavoriteMovieIds().toSet();
  }

  /// 좋아요 토글
  Future<void> toggleFavorite(MovieEntity movie) async {
    final repository = ref.read(favoriteRepositoryProvider);
    final success = await repository.toggleFavorite(movie);

    if (success) {
      if (state.contains(movie.id)) {
        state = {...state}..remove(movie.id);
      } else {
        state = {...state, movie.id};
      }
      
      // 좋아요 영화 목록도 같이 업데이트
      ref.read(favoriteMoviesProvider.notifier).refresh();
    }
  }

  // 특정 영화가 좋아요 체크됐는지
  bool isFavorite(int movieId) => state.contains(movieId);
}

final favoriteProvider =
    NotifierProvider<FavoriteNotifier, Set<int>>(() => FavoriteNotifier());

class FavoriteMoviesNotifier extends Notifier<List<MovieEntity>> {
  @override
  List<MovieEntity> build() {
    final repository = ref.watch(favoriteRepositoryProvider);
    return repository.getFavoriteMovies();
  }

  void refresh() {
    final repository = ref.read(favoriteRepositoryProvider);
    state = repository.getFavoriteMovies();
  }
}

/// 좋아요한 영화 전체 정보 Provider
final favoriteMoviesProvider =
    NotifierProvider<FavoriteMoviesNotifier, List<MovieEntity>>(
  () => FavoriteMoviesNotifier(),
);
