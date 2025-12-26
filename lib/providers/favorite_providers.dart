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
  Future<void> toggleFavorite(int movieId) async {
    final repository = ref.read(favoriteRepositoryProvider);
    final success = await repository.toggleFavorite(movieId);

    if (success) {
      if (state.contains(movieId)) {
        state = {...state}..remove(movieId);
      } else {
        state = {...state, movieId};
      }
    }
  }

  // 특정 영화가 좋아요 체크됐는지
  bool isFavorite(int movieId) => state.contains(movieId);
}

final favoriteProvider =
    NotifierProvider<FavoriteNotifier, Set<int>>(() => FavoriteNotifier());
