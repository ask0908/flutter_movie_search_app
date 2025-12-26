import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/core/constants/api_constants.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_movie_search_app/providers/favorite_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class FavoriteMovieListItem extends ConsumerWidget {
  final MovieEntity movie;

  const FavoriteMovieListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteProvider).contains(movie.id);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(12),
        child: HStack([
          _buildPosterImage(),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMovieInfo(),
          ),
          _buildFavoriteButton(ref, isFavorite),
        ]),
      ),
    );
  }

  Widget _buildPosterImage() {
    final posterUrl = movie.getPosterUrl(
      ApiConstants.imageBaseUrl,
      ApiConstants.posterSize,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 90,
        height: double.infinity,
        child: posterUrl != null
            ? CachedNetworkImage(
          imageUrl: posterUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(
              Icons.movie,
              size: 40,
              color: Colors.grey[600],
            ),
          ),
        )
            : Container(
          color: Colors.grey[300],
          child: Icon(
            Icons.movie,
            size: 40,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  /// 영화 정보 (제목, 평점, 설명)
  Widget _buildMovieInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 영화 제목
        Text(
          movie.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        // 평점
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 16,
              color: Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              movie.voteAverage.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // 최대 3줄 설명
        Expanded(
          child: Text(
            movie.overview,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// 좋아요 버튼
  Widget _buildFavoriteButton(WidgetRef ref, bool isFavorite) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 28,
      ),
      onPressed: () {
        ref.read(favoriteProvider.notifier).toggleFavorite(movie.id);
        debugPrint("좋아요 제거 완료 : ${movie.id}");
      },
    );
  }

}
