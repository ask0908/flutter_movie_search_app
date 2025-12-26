import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  // base url
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // API Key
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  // Bearer Token
  static String get bearerToken => dotenv.env['TMDB_BEARER_TOKEN'] ?? '';

  // 이미지 base url
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String posterSize = 'w200';
  static const String backdropSize = 'w780';

  // 엔드 포인트
  static const String nowPlaying = '/movie/now_playing';
  static const String popular = '/movie/popular';
  static const String topRated = '/movie/top_rated';
  static const String upcoming = '/movie/upcoming';
  static const String movieDetail = '/movie/{movie_id}';
  static const String search = '/search/movie';

  // 기본 파라미터
  static const String language = 'ko-KR';
  static const bool includeAdult = false;

  // Bearer Token 제대로 로드됐는지
  static bool get isTokenValid => bearerToken.isNotEmpty;
}
