import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/movie_category_section.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Movie App'),
        centerTitle: true,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (val) => themeProvider.toggleTheme(val),
          ),
        ],
      ),
      body: Column(
        children: [
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
              onSubmitted: (query) => movieProvider.searchMovies(query),
            ),
          ),

          Expanded(
            child: movieProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
              children: [
                MovieCategorySection(
                  title: '📽️ Latest Releases',
                  movies: movieProvider.latestMovies,
                ),
                MovieCategorySection(
                  title: '🔥 Most Popular',
                  movies: movieProvider.popularMovies,
                ),
                MovieCategorySection(
                  title: '🏆 Top Rated',
                  movies: movieProvider.topRatedMovies,
                ),
                MovieCategorySection(
                  title: '⏳ Upcoming',
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
