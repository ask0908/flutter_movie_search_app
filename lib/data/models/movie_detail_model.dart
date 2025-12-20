import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  final int id;
  final String title;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  final double popularity;

  // 상세 정보 추가 필드들
  final int runtime;  // 상영 시간 (분)
  final String status;  // 상태 (Released, Post Production 등)
  final int? budget;  // 제작비
  final int? revenue;  // 수익

  @JsonKey(name: 'genres')
  final List<GenreModel> genres;  // 장르 정보 (id와 name 포함)

  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyModel>? productionCompanies;

  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageModel>? spokenLanguages;

  const MovieDetailModel({
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
    required this.runtime,
    required this.status,
    this.budget,
    this.revenue,
    required this.genres,
    this.productionCompanies,
    this.spokenLanguages,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);

  // Entity로 변환
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      genreIds: genres.map((g) => g.id).toList(),
    );
  }
}

// 장르 모델
@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  const GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

// 제작사 모델
@JsonSerializable()
class ProductionCompanyModel {
  final int id;
  final String name;

  @JsonKey(name: 'logo_path')
  final String? logoPath;

  const ProductionCompanyModel({
    required this.id,
    required this.name,
    this.logoPath,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyModelToJson(this);
}

// 언어 모델
@JsonSerializable()
class SpokenLanguageModel {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;

  final String name;

  const SpokenLanguageModel({
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageModelToJson(this);
}
