import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/domain/entity/movie_entity.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_card.dart';

class HorizontalMovieList extends StatelessWidget {

  final List<MovieEntity> movieList;

  const HorizontalMovieList({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    if (movieList.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(
          child: Text("영화 데이터가 없습니다."),
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return Padding(
            // 영화 포스터 사이 간격
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: MovieCard(movie: movieList[index]),
          );
        },
      ),
    );
  }
}
