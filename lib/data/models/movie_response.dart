import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final int page;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  final List<MovieModel> results;

  const MovieResponse({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
