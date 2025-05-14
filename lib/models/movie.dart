class Movie {
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double rating;
  bool isFavorite;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
    this.isFavorite = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      rating: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
