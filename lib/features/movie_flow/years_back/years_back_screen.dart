// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widgets/primary_button.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recommendation/features/movie_flow/result/result_screen.dart';

class YearsBackScreen extends ConsumerWidget {
  const YearsBackScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:
              ref.read(movieFlowControllerProvider.notifier).previousPage,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'How many years back should we check for?',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${ref.watch(movieFlowControllerProvider).yearsBack}',
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  'Years back',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color:
                        theme.textTheme.headlineMedium?.color?.withOpacity(.62),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Slider(
              value:
                  ref.watch(movieFlowControllerProvider).yearsBack.toDouble(),
              onChanged: (value) {
                ref
                    .read(movieFlowControllerProvider.notifier)
                    .updateYearsBack(value.toInt());
              },
              min: 0,
              max: 70,
              divisions: 70,
              label: '${ref.watch(movieFlowControllerProvider).yearsBack}',
            ),
            const Spacer(),
            PrimaryButton(
                onPressed: () async {
                  await ref
                      .read(movieFlowControllerProvider.notifier)
                      .getRecommendedMovie();
                  Navigator.of(context).push(ResultScreen.route());
                },
                isloading: ref.watch(movieFlowControllerProvider).movie
                    is AsyncLoading,
                text: 'Amazing'),
            const SizedBox(
              height: kMediumSpacing,
            )
          ],
        ),
      ),
    );
  }
}
