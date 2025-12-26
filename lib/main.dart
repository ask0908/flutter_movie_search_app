import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_search_app/core/constants/api_constants.dart';
import 'package:flutter_movie_search_app/core/router/app_router.dart';
import 'package:flutter_movie_search_app/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_dimensions.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  if (!ApiConstants.isTokenValid) {
    debugPrint("tmdb bearer 토큰 로드되지 않음");
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "영화 검색 앱",
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movies",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppDimensions.spacingS
            ),
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
      body: const Placeholder(),
    );
  }
}
