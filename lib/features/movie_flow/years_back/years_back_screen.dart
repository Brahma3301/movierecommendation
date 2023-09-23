// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widgets/primary_button.dart';
import 'package:movie_recommendation/features/movie_flow/result/result_screen.dart';

class YearsBackScreen extends StatefulWidget {
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  const YearsBackScreen({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  @override
  State<YearsBackScreen> createState() => _YearsBackScreenState();
}

class _YearsBackScreenState extends State<YearsBackScreen> {
  double yearsback = 10;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: widget.previousPage,
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
                  '${yearsback.ceil()}',
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
              value: yearsback,
              onChanged: (value) {
                setState(() {
                  yearsback = value;
                });
              },
              min: 0,
              max: 70,
              divisions: 70,
              label: '${yearsback.ceil()}',
            ),
            const Spacer(),
            PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(ResultScreen.route());
                },
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
