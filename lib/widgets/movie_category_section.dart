import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCategorySection extends StatefulWidget {
  final String title;
  final List<Movie> movies;

  const MovieCategorySection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  State<MovieCategorySection> createState() => _MovieCategorySectionState();
}

class _MovieCategorySectionState extends State<MovieCategorySection> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final displayMovies = showAll ? widget.movies : widget.movies.take(5).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: Text(widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ),

          // Horizontal movie list
          SizedBox(
            height: 240,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: displayMovies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final movie = displayMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movie)),
                    );
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: movie.posterPath.isNotEmpty
                            ? Image.network(
                          'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                          height: 160,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                            : const Icon(Icons.image_not_supported, size: 100),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        movie.releaseDate.isNotEmpty ? movie.releaseDate : 'No date',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text('${movie.rating}', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // See All Button
          GestureDetector(
            onTap: () => setState(() => showAll = !showAll),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(showAll ? 'Show Less' : 'See All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    const SizedBox(width: 4),
                    Icon(showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
