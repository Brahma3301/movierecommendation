// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movie_recommendation/core/constants.dart';

import 'genre.dart';

class ListCard extends StatelessWidget {
  final VoidCallback onTap;
  final Genre genre;

  const ListCard({
    Key? key,
    required this.onTap,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Material(
        color: genre.isSelected
            ? Theme.of(context).colorScheme.secondary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(kBorderRadius),
          onTap: onTap,
          child: Container(
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              genre.name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
