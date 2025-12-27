import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/presentation/screens/favorite/favorite_movie_list_item.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_movie_search_app/providers/favorite_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const MovieHomeTitleText(title: "Liked Movies"),
      ),
      body: favoriteMovies.isEmpty
          ? _buildEmptyFavoriteState()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 8,
              ),
              itemCount: favoriteMovies.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  FavoriteMovieListItem(movie: favoriteMovies[index]),
            ),
    );
  }

  Widget _buildEmptyFavoriteState() {
    return Center(
      child: VStack(
        crossAlignment: CrossAxisAlignment.center,
        [
          Icon(
            Icons.favorite_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "좋아하는 영화가 없습니다",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "영화 카드의 하트 아이콘을 눌러 추가하세요",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}