import 'package:flutter/material.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// const genresMock = [
//   Genre(name: 'Action'),
//   Genre(name: 'Comedy'),
//   Genre(name: 'Horror'),
//   Genre(name: 'Anime'),
//   Genre(name: 'Drama'),
//   Genre(name: 'Family'),
//   Genre(name: 'Romance'),
// ];

// const movieMock = Movie(
//     title: 'The Hulk',
//     overview: 'nnn',
//     voteAverage: 4.8,
//     genres: [Genre(name: 'Action'), Genre(name: 'Fantasy')],
//     releaseDate: '2019-05-24');

class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final AsyncValue<List<Genre>> genres;
  final AsyncValue<Movie> movie;

  const MovieFlowState({
    required this.pageController,
    required this.movie,
    required this.genres,
    this.rating = 5,
    this.yearsBack = 10,
  });

  MovieFlowState copyWith(
      {PageController? pageController,
      int? rating,
      int? yearsBack,
      AsyncValue<List<Genre>>? genres,
      AsyncValue<Movie>? movie}) {
    return MovieFlowState(
        pageController: pageController ?? this.pageController,
        rating: rating ?? this.rating,
        yearsBack: yearsBack ?? this.yearsBack,
        genres: genres ?? this.genres,
        movie: movie ?? this.movie);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieFlowState &&
        other.pageController == pageController &&
        other.rating == rating &&
        other.yearsBack == yearsBack &&
        other.genres == genres &&
        other.movie == movie;
  }

  @override
  // TODO: implement hashCode
  int get hashCode {
    return pageController.hashCode ^
        rating.hashCode ^
        yearsBack.hashCode ^
        genres.hashCode ^
        movie.hashCode;
  }
}
