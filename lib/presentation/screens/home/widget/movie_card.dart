import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/core/constants/api_constants.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

class MovieCard extends StatefulWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 225,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildPosterImage(),
                _buildFavoriteButton(),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPosterImage() {
    final posterUrl =
        widget.movie.getPosterUrl(ApiConstants.imageBaseUrl, 'w500');

    return GestureDetector(
      onTap: () {
        debugPrint("영화 ${widget.movie.id} 클릭 -> 상세 화면 이동");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: posterUrl != null
            ? Image.network(
                posterUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder();
                },
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: Icon(
        Icons.movie,
        size: 64,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    bool isFavorite = true;

    return Positioned(
      right: 8,
      top: 8,
      child: GestureDetector(
        onTap: () {
          setState(() {
            debugPrint("영화 ${widget.movie.id} 좋아요 토글");
            // isFavorite = !isFavorite;
          });
        },
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}