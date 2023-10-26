import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow_state.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';
import 'movie_service.dart';

final movieFlowControllerProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
        (ref) {
  return MovieFlowController(
      MovieFlowState(
          pageController: PageController(),
          movie: AsyncValue.data(Movie.initial()),
          genres: AsyncValue.data([])),
      ref.watch(movieServiceProvider));
});

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(
    MovieFlowState state,
    this._movieService,
  ) : super(state) {
    loadGenres();
  }

  final MovieService _movieService;
  Future<void> loadGenres() async {
    state = state.copyWith(genres: const AsyncValue.loading());
    final result = await _movieService.getGenres();
    result.when((genres) {
      final updatedgenres = AsyncValue.data(genres);
      state = state.copyWith(genres: updatedgenres);
    }, (error) {
      state = state.copyWith(genres: AsyncValue.error(error));
    });
  }

  Future<void> getRecommendedMovie() async {
    state = state.copyWith(movie: const AsyncValue.loading());
    final selectedGenres = state.genres.asData?.value
            .where((element) => element.isSelected == true)
            .toList(growable: false) ??
        [];
    final result = await _movieService.getRecommendedMovies(
        state.rating, state.yearsBack, selectedGenres);
    result.when((movie) {
      state = state.copyWith(movie: AsyncValue.data(movie));
    }, (error) {
      state = state.copyWith(movie: AsyncValue.error(error));
    });
  }

  void toggleSelected(Genre genre) {
    state = state.copyWith(
      genres: AsyncValue.data([
        for (final oldGenre in state.genres.asData!.value)
          if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
      ]),
    );
  }

  void updateRating(int updatedRating) {
    state = state.copyWith(rating: updatedRating);
  }

  void updateYearsBack(int updatedYearsBack) {
    state = state.copyWith(yearsBack: updatedYearsBack);
  }

  void nextPage() {
    if (state.pageController.page! >= 1) {
      if (!state.genres.asData!.value
          .any((element) => element.isSelected == true)) {
        return;
      }
    }
    state.pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic);
  }

  void previousPage() {
    state.pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.pageController.dispose();
  }
}
