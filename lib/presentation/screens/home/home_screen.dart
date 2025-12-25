import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/core/theme/app_dimensions.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/top_rated_movie_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const MovieHomeTitleText(title: "Movies"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spacingS),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                debugPrint("검색 클릭 -> 검색 화면 이동해야 함");
              },
              tooltip: "영화 검색",
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          // Top Rated + 전체 보기 텍스트
          TopRatedMovieContainer(),
          // // Now Playing
          // OtherMovieContainer(
          //   movieType: MovieType.nowplaying,
          // ),
          // // Popular
          // OtherMovieContainer(
          //   movieType: MovieType.popular,
          // ),
          // // Upcoming
          // OtherMovieContainer(
          //   movieType: MovieType.upcoming,
          // ),
        ],
      )
    );
  }
}