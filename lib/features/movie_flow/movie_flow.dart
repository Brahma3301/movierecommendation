import 'package:flutter/material.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre_screen.dart';
import 'package:movie_recommendation/features/movie_flow/landing/landing_screen.dart';
import 'package:movie_recommendation/features/movie_flow/rating/rating_screen.dart';
import 'package:movie_recommendation/features/movie_flow/years_back/years_back_screen.dart';

class MovieFlow extends StatefulWidget {
  const MovieFlow({super.key});

  @override
  State<MovieFlow> createState() => _MovieFlowState();
}

class _MovieFlowState extends State<MovieFlow> {
  final pagecontroller = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    pagecontroller.dispose();
    super.dispose();
  }

  void nextpage() {
    pagecontroller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic);
  }

  void previouspage() {
    pagecontroller.previousPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pagecontroller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LandingScreen(nextPage: nextpage, previousPage: previouspage),
        GenreScreen(nextPage: nextpage, previousPage: previouspage),
        RatingScreen(nextPage: nextpage, previousPage: previouspage),
        YearsBackScreen(nextPage: nextpage, previousPage: previouspage),
        Scaffold(
          body: Container(
            color: Colors.green,
          ),
        )
      ],
    );
  }
}
