// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movie_recommendation/core/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;

  final bool isloading;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.isloading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius / 2),
              ),
              fixedSize: Size(width, 48)),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isloading)
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                )
              else
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge,
                )
            ],
          )),
    );
  }
}
