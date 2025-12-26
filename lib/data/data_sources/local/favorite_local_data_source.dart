import 'package:shared_preferences/shared_preferences.dart';

class FavoriteLocalDataSource {
  static const String _favoritesKey = 'favorite_movies';
  final SharedPreferences _prefs;

  FavoriteLocalDataSource(this._prefs);

  /// 좋아요한 영화 ID 리스트 가져오기
  List<int> getFavoriteMovieIds() {
    final List<String>? favoriteStrings = _prefs.getStringList(_favoritesKey);
    if (favoriteStrings == null) return [];
    return favoriteStrings.map((id) => int.parse(id)).toList();
  }

  /// 좋아요 추가
  Future<bool> addFavorite(int movieId) async {
    final favorites = getFavoriteMovieIds();
    if (!favorites.contains(movieId)) {
      favorites.add(movieId);
      return await _saveFavorites(favorites);
    }
    return true;
  }

  /// 좋아요 제거
  Future<bool> removeFavorite(int movieId) async {
    final favorites = getFavoriteMovieIds();
    favorites.remove(movieId);
    return await _saveFavorites(favorites);
  }

  /// 좋아요 여부 확인
  bool isFavorite(int movieId) {
    final favorites = getFavoriteMovieIds();
    return favorites.contains(movieId);
  }

  /// 좋아요 토글
  Future<bool> toggleFavorite(int movieId) async {
    if (isFavorite(movieId)) {
      return await removeFavorite(movieId);
    } else {
      return await addFavorite(movieId);
    }
  }

  /// 내부 저장 메서드
  Future<bool> _saveFavorites(List<int> favorites) async {
    final List<String> favoriteStrings =
    favorites.map((id) => id.toString()).toList();
    return await _prefs.setStringList(_favoritesKey, favoriteStrings);
  }
}