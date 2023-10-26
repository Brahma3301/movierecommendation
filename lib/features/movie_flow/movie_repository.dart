import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/enviroment_variables.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie_entity.dart';
import 'package:movie_recommendation/main.dart';
import 'package:movie_recommendation/core/failure.dart';

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
    try {
      final response = await dio.get('genre/movie/list', queryParameters: {
        'api_key': api,
        'language': 'en-US',
      });
      print(response);
      final result = List<Map<String, dynamic>>.from(response.data['genres']);
      print(result);
      final genres = result.map((e) => GenreEntity.fromMap(e)).toList();
      return genres;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message: 'No Internet Connection',
          exception: e,
        );
      }
      throw Failure(
          message: e.response?.statusMessage ?? 'Something went wrong',
          code: e.response?.statusCode);
    }
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genresId) async {
    try {
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
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message: 'No Internet Connection',
          exception: e,
        );
      }
      throw Failure(
          message: e.response?.statusMessage ?? 'Something went wrong',
          code: e.response?.statusCode);
    }
  }
}
