import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/now_playing_movie_container.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/popular_movie_container.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/top_rated_movie_container.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/upcoming_movie_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const MovieHomeTitleText(title: "Movies"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Rated + 전체 보기 텍스트
            TopRatedMovieContainer(),
            // 현재 상영 중인 영화
            NowPlayingMovieContainer(),
            SizedBox(height: 16),
            // 현재 가장 인기 많은 영화
            PopularMovieContainer(),
            SizedBox(height: 16),
            // 개봉 예정 영화
            UpcomingMovieContainer(),
            SizedBox(height: 16),
          ],
        ),
      )
    );
  }
}