import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  final double? popularity;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  final bool? adult;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  const MovieModel({
    required this.id,
    required this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.popularity,
    this.genreIds,
    this.adult,
    this.originalLanguage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      originalTitle: originalTitle ?? title,
      overview: overview ?? "",
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate ?? "",
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
      popularity: popularity ?? 0.0,
      genreIds: genreIds ?? [],
    );
  }
}
