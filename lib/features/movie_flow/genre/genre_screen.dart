import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widgets/primary_button.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow_controller.dart';

import 'list_card.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:
              ref.read(movieFlowControllerProvider.notifier).previousPage,
          color: Colors.white,
        ),
      ),
      body: Column(children: [
        Text(
          'Let\'s start with a genre',
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Expanded(
            child: ref.watch(movieFlowControllerProvider).genres.when(
                data: (genres) {
                  return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: kListItemSpacing),
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        return ListCard(
                          genre: genre,
                          onTap: () => ref
                              .read(movieFlowControllerProvider.notifier)
                              .toggleSelected(genre),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: kListItemSpacing,
                        );
                      },
                      itemCount: genres.length);
                },
                error: (e, s) {
                  return const Text('something went wrong');
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ))),
        PrimaryButton(
          onPressed: ref.read(movieFlowControllerProvider.notifier).nextPage,
          text: 'Continue',
        ),
        const SizedBox(
          height: kMediumSpacing,
        )
      ]),
    );
  }
}
