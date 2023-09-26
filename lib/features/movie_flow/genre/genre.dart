import 'package:flutter/material.dart';
import 'genre_entity.dart';

@immutable
class Genre {
  final String name;
  final bool isSelected;
  final int id;

  const Genre({required this.name, this.isSelected = false, this.id = 0});
  Genre toggleSelected() {
    return Genre(name: name, id: id, isSelected: !isSelected);
  }

  factory Genre.fromEntity(GenreEntity entity) {
    return Genre(name: entity.name, id: entity.id, isSelected: false);
  }

  @override
  String toString() => 'Genre(name: $name,isSelected: $isSelected,id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Genre &&
        other.name == name &&
        other.isSelected == isSelected &&
        other.id == id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => name.hashCode ^ isSelected.hashCode ^ id.hashCode;
}
