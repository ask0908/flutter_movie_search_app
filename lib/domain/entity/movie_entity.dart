class MovieEntity {
  final int id;
  final String title;
  final String originalTitle;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genreIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds,
    };
  }

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList() ??
          [],
    );
  }

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