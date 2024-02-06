import 'package:flutter_api_sqflite/controllers/favoritepage_controller.dart';

class FavoriteMovie {
  bool isFav(FavoritePageController favoritePageController) {
    return favoritePageController.favorites.contains(id);
  }

  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;

  FavoriteMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }

  factory FavoriteMovie.fromMap(Map<String, dynamic> map) {
    return FavoriteMovie(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      posterPath: map['posterPath'],
      backdropPath: map['backdropPath'],
      releaseDate: map['releaseDate'],
      voteAverage: map['voteAverage'],
    );
  }
}
