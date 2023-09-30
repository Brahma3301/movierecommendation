import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/enviroment_variables.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie_entity.dart';
import 'package:movie_recommendation/main.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TMDBMovieRepository(dio: dio);
});

abstract class MovieRepository {
  Future<List<GenreEntity>> getMoviesGenres();
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genresId);
}

class TMDBMovieRepository implements MovieRepository {
  final Dio dio;
  TMDBMovieRepository({required this.dio});

  @override
  Future<List<GenreEntity>> getMoviesGenres() async {
    final response = await dio.get('genre/movie/list', queryParameters: {
      'api_key': api,
      'language': 'en-US',
    });
    final result = List<Map<String, dynamic>>.from(response.data['genres']);
    final genres = result.map((e) => GenreEntity.fromMap(e)).toList();
    return genres;
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genresId) async {
    final response = await dio.get('discover/movie', queryParameters: {
      'api_key': api,
      'language': 'en-US',
      'sort_by': 'popularity.desc',
      'include_adult': false,
      'vote_average.gte': rating,
      'page': 1,
      'release_date.gte': date,
      'with_genres': genresId,
    });
    final result = List<Map<String, dynamic>>.from(response.data['results']);
    final movies = result.map((e) => MovieEntity.fromMap(e)).toList();
    return movies;
  }
}
