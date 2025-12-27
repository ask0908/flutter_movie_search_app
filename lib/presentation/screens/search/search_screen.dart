import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_movie_search_app/presentation/screens/favorite/favorite_movie_list_item.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_movie_search_app/providers/movie_providers.dart';
import 'package:flutter_movie_search_app/providers/search_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _currentQuery = "";
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(recentSearchesProvider.notifier).loadRecentSearches();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _currentQuery = query;
      _hasSearched = true;
    });

    ref.read(recentSearchesProvider.notifier).addSearch(query);
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _hasSearched = false;
      _currentQuery = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = ref.watch(recentSearchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const MovieHomeTitleText(title: "Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 검색 입력창
            _buildSearchField(),
            const SizedBox(height: 16),
            // 검색 결과, 최근 검색어
            Expanded(
              child: _hasSearched
                  ? _buildSearchResults()
                  : _buildRecentSearches(recentSearches),
            ),
          ],
        ),
      ),
    );
  }

  /// 검색 입력 필드
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: '영화 제목을 입력하세요',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                onPressed: _clearSearch,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        setState(() {}); // suffixIcon 업데이트를 위한 빈 setState
      },
      onSubmitted: (value) {
        _performSearch();
      },
    );
  }

  /// 최근 검색어 영역
  Widget _buildRecentSearches(List<String> recentSearches) {
    return Column(
      children: [
        // 최근 검색어 텍스트 위치가 바뀌지 않게 SizedBox로 감쌈
        SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최근 검색어',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (recentSearches.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      ref.read(recentSearchesProvider.notifier).clearAll();
                    },
                    child: const Text(
                      '전부 제거',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // 최근 검색어 리스트
        Expanded(
          child: recentSearches.isEmpty
              ? Center(
                  child: Text(
                    '최근 검색어가 없습니다',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: recentSearches.length,
                  itemBuilder: (context, index) {
                    final searchQuery = recentSearches[index];
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(searchQuery),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () {
                          ref
                              .read(recentSearchesProvider.notifier)
                              .removeSearch(searchQuery);
                        },
                      ),
                      onTap: () {
                        _searchController.text = searchQuery;
                        _performSearch();
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    final searchResultsAsync = ref.watch(movieSearchProvider(_currentQuery));

    return searchResultsAsync.when(
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: Text(
              '검색 결과가 없습니다',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          );
        }

        // Sliver를 사용한 단일 스크롤 영역
        return CustomScrollView(
          slivers: [
            // 검색 결과 헤더
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: Text(
                  '"$_currentQuery"로 검색한 결과입니다',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 간격
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),

            // 검색 결과 리스트
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FavoriteMovieListItem(movie: movie),
                  );
                },
                childCount: movies.length,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          '검색 중 오류가 발생했습니다\n$error',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}