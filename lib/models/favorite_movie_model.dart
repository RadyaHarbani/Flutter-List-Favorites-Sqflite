class FavoriteMovie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  FavoriteMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
    };
  }

  factory FavoriteMovie.fromMap(Map<String, dynamic> map) {
    return FavoriteMovie(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      posterPath: map['posterPath'],
    );
  }
}
