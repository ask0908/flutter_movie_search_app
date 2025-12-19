import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/core/theme/app_theme.dart';

import 'core/theme/app_dimensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: const MyHomePage(),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello, World'),
          ],
        ),
      ),
    );
  }
}
