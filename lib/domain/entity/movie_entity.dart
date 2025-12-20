class MovieEntity {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genreIds,
  });

  // 영화 포스터 URL
  String? getPosterUrl(String baseUrl, String size) {
    return posterPath != null ? '$baseUrl/$size$posterPath' : null;
  }

  // 백드롭 이미지 URL
  String? getBackdropUrl(String baseUrl, String size) {
    return backdropPath != null ? '$baseUrl/$size$backdropPath' : null;
  }

  // 평점(%)
  int get votePercentage => (voteAverage * 10).round();
}