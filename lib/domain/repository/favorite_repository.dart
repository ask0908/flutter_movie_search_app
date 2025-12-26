abstract class FavoriteRepository {
  List<int> getFavoriteMovieIds();
  Future<bool> toggleFavorite(int movieId);
  bool isFavorite(int movieId);
}