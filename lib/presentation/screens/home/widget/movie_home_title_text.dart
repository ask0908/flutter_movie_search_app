import 'package:flutter/material.dart';

class MovieHomeTitleText extends StatelessWidget {

  final String title;

  const MovieHomeTitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
