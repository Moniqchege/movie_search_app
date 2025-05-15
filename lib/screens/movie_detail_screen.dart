import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🎬 Animated App Bar with Hero Poster
        SliverAppBar(
        expandedHeight: 300,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
        title: Text(movie.title, style: const TextStyle(fontSize: 16)),
    background: Stack( // <--- Start: Replace Hero directly with Stack
    fit: StackFit.expand, // Stack will fill the available space
    children: [
    // The original image widget (now the first child of the Stack)
    Hero(
    tag: movie.title,
    child: movie.posterPath.isNotEmpty
    ? FadeInImage.assetNetwork(
    placeholder: 'assets/placeholder.png',
    image: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
    fit: BoxFit.cover,
    )
        : const Icon(Icons.image_not_supported),
    ),
    // <--- Start: Add the gradient overlay here
    Positioned.fill( // Positioned.fill makes the Container fill the Stack
    child: Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
      colors: [
        Colors.black54, // Adjust this color and opacity
        Colors.transparent,
      ],
      stops: [0.0, 0.5], // Adjust these values
    ),
    ),
    ),
    ),
      // <--- End: Gradient overlay added
    ],
    ), // <--- End: Stack ends here
        ),
        ),


    // 📄 Movie Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(movie.releaseDate),
                      const SizedBox(width: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 6),
                      Text('${movie.rating}/10'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
