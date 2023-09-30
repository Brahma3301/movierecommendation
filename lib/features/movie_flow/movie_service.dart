import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/movie_repository.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return TMDBmovieService(movieRepository);
});

abstract class MovieService {
  Future<List<Genre>> getGenres();
  Future<Movie> getRecommendedMovies(
      int rating, int yearsback, List<Genre> genres,
      [DateTime? yearsBackfromDate]);
}

class TMDBmovieService implements MovieService {
  final MovieRepository _movieRepository;

  TMDBmovieService(this._movieRepository);
  @override
  Future<List<Genre>> getGenres() async {
    final genreEntities = await _movieRepository.getMoviesGenres();
    final genre = genreEntities.map((e) => Genre.fromEntity(e)).toList();
    return genre;
  }

  @override
  Future<Movie> getRecommendedMovies(
      int rating, int yearsback, List<Genre> genres,
      [DateTime? yearsBackfromDate]) async {
    final date = yearsBackfromDate ?? DateTime.now();
    final year = date.year - yearsback;
    final genreIds = genres.map((e) => e.id).toList().join(',');
    final movieEntites = await _movieRepository.getRecommendedMovies(
        rating.toDouble(), '$year-01-01', genreIds);
    final movies =
        movieEntites.map((e) => Movie.fromEntity(e, genres)).toList();
    final rnd = Random();
    final randomMovie = movies[rnd.nextInt(movies.length)];
    return randomMovie;
  }
}
