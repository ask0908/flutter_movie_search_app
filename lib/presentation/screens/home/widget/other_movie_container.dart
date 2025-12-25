import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/movie_type_enum.dart';
import 'package:velocity_x/velocity_x.dart';

class OtherMovieContainer extends StatefulWidget {
  final MovieType movieType;

  const OtherMovieContainer({super.key, required this.movieType});

  @override
  State<OtherMovieContainer> createState() => _OtherMovieContainerState();
}

class _OtherMovieContainerState extends State<OtherMovieContainer> {
  // 세로로 긴 포스터 + 영화명 + 좋아요 버튼
  late MovieType movieType;

  @override
  void initState() {
    super.initState();
    movieType = widget.movieType;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}