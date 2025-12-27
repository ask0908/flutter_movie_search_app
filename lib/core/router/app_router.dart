import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/presentation/screens/main/main_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_movie_search_app/presentation/screens/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        "화면을 찾을 수 없음 : ${state.uri}"
      ),
    ),
  ),
  // 라우트 정의
  routes: [
    // 스플래시
    GoRoute(
      path: "/",
      name: "splash",
      builder: (context, state) => const SplashScreen(),
    ),

    // 홈
    GoRoute(
      path: "/main",
      name: "main",
      builder: (context, state) => const MainScreen(),
    ),

    // 검색
    // GoRoute(
    //   path: "/search",
    //   name: "search",
    //   builder: (context, state) => const SearchScreen(),
    // ),

    // 영화 상세
    // GoRoute(
    //   path: '/movie/:id',
    //   name: 'movie-detail',
    //   builder: (context, state) {
    //     final movieId = int.parse(state.pathParameters['id']!);
    //     return MovieDetailScreen(movieId: movieId);
    //   },
    // ),
    // 좋아요 모아보기
  ]
);