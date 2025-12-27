import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchesNotifier extends Notifier<List<String>> {
  static const String _recentSearchesKey = 'recentSearches';
  static const int _maxRecentSearches = 10;

  @override
  List<String> build() {
    loadRecentSearches();
    return [];
  }

  /// 최근 검색어 조회
  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(_recentSearchesKey) ?? [];
    state = searches;
  }

  /// 검색어 추가
  Future<void> addSearch(String query) async {
    if (query.trim().isEmpty) return;

    final updatedSearches = [...state];

    // 이미 검색어가 있으면 없앰 -> 최신 검색어로 설정하기 위함
    updatedSearches.remove(query);
    updatedSearches.insert(0, query);

    // 최대 개수 제한
    if (updatedSearches.length > _maxRecentSearches) {
      updatedSearches.removeLast();
    }

    state = updatedSearches;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, updatedSearches);
  }

  /// 전체 삭제
  Future<void> clearAll() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
  }

  /// 특정 검색어 삭제
  Future<void> removeSearch(String query) async {
    final updatedSearches = [...state];
    updatedSearches.remove(query);
    state = updatedSearches;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, updatedSearches);
  }
}

final recentSearchesProvider =
    NotifierProvider<RecentSearchesNotifier, List<String>>(
        () => RecentSearchesNotifier()
    );
