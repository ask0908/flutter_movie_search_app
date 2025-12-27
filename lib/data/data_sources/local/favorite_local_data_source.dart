import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

class FavoriteLocalDataSource {
  static const String _favoritesKey = 'favorite_movies';
  static const String _favoriteMoviesDataKey = 'favorite_movies_data';
  final SharedPreferences _prefs;

  FavoriteLocalDataSource(this._prefs);

  /// 좋아요한 영화 ID 리스트 가져오기
  List<int> getFavoriteMovieIds() {
    final List<String>? favoriteStrings = _prefs.getStringList(_favoritesKey);
    if (favoriteStrings == null) return [];
    return favoriteStrings.map((id) => int.parse(id)).toList();
  }

  /// 좋아요한 영화 전체 정보 가져오기
  List<MovieEntity> getFavoriteMovies() {
    final String? jsonString = _prefs.getString(_favoriteMoviesDataKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => MovieEntity.fromJson(json)).toList();
    } catch (e) {
      debugPrint('좋아요 영화 데이터 로드 실패: $e');
      return [];
    }
  }

  /// 좋아요 추가
  Future<bool> addFavorite(MovieEntity movie) async {
    // ID 저장
    final favoriteIds = getFavoriteMovieIds();
    if (!favoriteIds.contains(movie.id)) {
      favoriteIds.add(movie.id);
      await _prefs.setStringList(
        _favoritesKey,
        favoriteIds.map((id) => id.toString()).toList(),
      );
    }

    // 영화 데이터 저장
    final favoriteMovies = getFavoriteMovies();
    if (!favoriteMovies.any((m) => m.id == movie.id)) {
      favoriteMovies.add(movie);
      final jsonString = json.encode(
        favoriteMovies.map((m) => m.toJson()).toList(),
      );
      await _prefs.setString(_favoriteMoviesDataKey, jsonString);
    }

    return true;
  }

  /// 좋아요 제거
  Future<bool> removeFavorite(int movieId) async {
    // ID 제거
    final favoriteIds = getFavoriteMovieIds();
    favoriteIds.remove(movieId);
    await _prefs.setStringList(
      _favoritesKey,
      favoriteIds.map((id) => id.toString()).toList(),
    );

    // 영화 데이터도 같이 제거
    final favoriteMovies = getFavoriteMovies();
    favoriteMovies.removeWhere((movie) => movie.id == movieId);
    final jsonString = json.encode(
      favoriteMovies.map((m) => m.toJson()).toList(),
    );
    await _prefs.setString(_favoriteMoviesDataKey, jsonString);

    return true;
  }

  /// 좋아요 여부 확인
  bool isFavorite(int movieId) {
    final favorites = getFavoriteMovieIds();
    return favorites.contains(movieId);
  }

  /// 좋아요 토글
  Future<bool> toggleFavorite(MovieEntity movie) async {
    if (isFavorite(movie.id)) {
      return await removeFavorite(movie.id);
    } else {
      return await addFavorite(movie);
    }
  }
}