import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/core/constants/api_constants.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_movie_search_app/providers/movie_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class TopRatedMovieContainer extends ConsumerWidget {
  const TopRatedMovieContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return VStack([
      HStack([
        MovieHomeTitleText(
          title: "최고 평점 영화",
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            debugPrint("Top Rated 영화 전체보기 화면 이동");
          },
          child: Text(
            "전체보기",
            style: TextStyle(
              color: Color(0xFFCFBBFE),
            ),
          ),
        ),
      ]).pOnly(left: 16, right: 16, top: 16),
      topRatedMovies.when(
        loading: () => SizedBox(
          height: 200,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (e, stack) => SizedBox(
          height: 200,
          child: Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 8),
                  Text('영화 데이터를 불러올 수 없습니다'),
                  SizedBox(height: 4),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(topRatedMoviesProvider);
                    },
                    child: Text('다시 시도'),
                  ),
                ],
              ),
            ),
          ),
        ),
        data: (movies) => _generateTopRatedMovieItems(movies),
      ),
    ]);
  }

  Widget _generateTopRatedMovieItems(List<MovieEntity> topRatedMovies) {
    // 데이터가 없는 경우 처리
    if (topRatedMovies.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text("최고 인기 영화 데이터가 없습니다."),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: topRatedMovies.length,
        itemBuilder: (context, index) {
          return _TopRatedMovieCard(
            movie: topRatedMovies[index],
            rank: index + 1,
          );
        },
      ),
    );
  }
}

class _TopRatedMovieCard extends StatelessWidget {
  final MovieEntity movie;
  final int rank;

  const _TopRatedMovieCard({
    required this.movie,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.none,
      child: SizedBox(
        width: 350,
        height: 180,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildRankNumber(),
            _buildMovieContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRankNumber() {
    return Positioned(
      right: 8,
      bottom: 4,
      child: Text(
        rank.toString(),
        style: TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withOpacity(0.1),
          letterSpacing: -10,
        ),
      ),
    );
  }

  Widget _buildMovieContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12,
        top: 12,
      ),
      child: HStack(
        crossAlignment: CrossAxisAlignment.start,
        [
          _buildPosterImage(),
          SizedBox(width: 12),
          Expanded(
            child: _buildMovieInfo(context),
          ),
        ],
      ),
    );
  }

  /// 포스터 이미지
  Widget _buildPosterImage() {
    final posterUrl = movie.getPosterUrl(ApiConstants.imageBaseUrl, 'w200');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: posterUrl != null
          ? CachedNetworkImage(
              imageUrl: posterUrl,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                debugPrint("top rated 이미지 로딩 실패 : $url");
                debugPrint("top rated api 에러 : $error");
                return _buildPlaceholderImage();
              },
            )
          : _buildPlaceholderImage(),
    );
  }

  /// 포스터 이미지 placeholder
  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.movie,
        size: 40,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildMovieInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: VStack([
        Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 6),
        // 평점, 장르
        _buildRatingAndGenre(context),
        SizedBox(height: 8),
        // 최대 3줄 영화 설명
        _buildOverviewText(context),
      ], crossAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildRatingAndGenre(BuildContext context) {
    return HStack([
      Icon(
        Icons.star,
        color: Colors.amber,
        size: 18,
      ),
      SizedBox(width: 4),
      // 평점
      Text(
        movie.voteAverage.toStringAsFixed(1),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(width: 8),
    ]);
  }

  Widget _buildOverviewText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Text(
        movie.overview,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          height: 1.3,
        ),
      ),
    );
  }
}
