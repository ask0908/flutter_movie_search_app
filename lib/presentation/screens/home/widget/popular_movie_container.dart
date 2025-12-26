import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/horizontal_movie_list.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_movie_search_app/providers/movie_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class PopularMovieContainer extends ConsumerWidget {
  const PopularMovieContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMovies = ref.watch(popularMoviesProvider);

    return VStack([
      MovieHomeTitleText(
        title: "현재 가장 인기 많은 영화!",
      ).pOnly(left: 16, right: 16, top: 16),
      popularMovies.when(
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
        data: (movies) => HorizontalMovieList(movieList: movies),
      ),
    ]);
  }
}
