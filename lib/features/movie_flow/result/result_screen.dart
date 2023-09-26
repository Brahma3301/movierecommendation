// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widgets/primary_button.dart';

import 'package:movie_recommendation/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';

class ResultScreen extends ConsumerWidget {
  static route({bool fullscreenDialog = true}) =>
      MaterialPageRoute(builder: (context) => const ResultScreen());
  const ResultScreen({super.key});

  final double movieheight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const CoverImage(),
                  Positioned(
                    bottom: -(movieheight) / 2,
                    width: MediaQuery.of(context).size.width,
                    child: MovieImageDetails(
                      movie: ref.watch(movieFlowControllerProvider).movie,
                      movieHeight: movieheight,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: movieheight / 2,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  ref.watch(movieFlowControllerProvider).movie.overview,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          )),
          PrimaryButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Find Another Movie'),
          const SizedBox(
            height: kMediumSpacing,
          )
        ],
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 298),
      child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Colors.transparent
                ]).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Placeholder()),
    );
  }
}

class MovieImageDetails extends ConsumerWidget {
  final Movie movie;
  final double movieHeight;
  const MovieImageDetails({
    Key? key,
    required this.movie,
    required this.movieHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: Placeholder(),
          ),
          const SizedBox(
            width: kMediumSpacing,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                movie.genresCommaSeperated,
                style: theme.textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Text(
                    movie.voteAverage.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.62)),
                  ),
                  const Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: Colors.amber,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
