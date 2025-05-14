import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/movie_category_section.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).initMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    final isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Movie Search'),
        centerTitle: true,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (val) {
              themeProvider.toggleTheme(val);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search input field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    movieProvider.searchMovies(_searchController.text);
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onSubmitted: (query) {
                movieProvider.searchMovies(query);
              },
            ),
          ),

          // Movie list or loading animation
          Expanded(
            child: movieProvider.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : isSearching
                ? ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return ListTile(
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                    width: 50,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.image_not_supported),
                  title: Text(movie.title),
                  subtitle: Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: movie.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      movieProvider.toggleFavorite(movie);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            )
                : ListView(
              children: [
                MovieCategorySection(
                  title: 'Latest',
                  movies: movieProvider.latestMovies,
                ),
                MovieCategorySection(
                  title: 'Popular',
                  movies: movieProvider.popularMovies,
                ),
                MovieCategorySection(
                  title: 'Top Rated',
                  movies: movieProvider.topRatedMovies,
                ),
                MovieCategorySection(
                  title: 'Upcoming',
                  movies: movieProvider.upcomingMovies,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
