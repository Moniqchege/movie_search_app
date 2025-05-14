import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Movie> _movies = [];
  List<Movie> _latestMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upcomingMovies = [];
  bool _isLoading = false;


  List<Movie> get movies => _movies;
  List<Movie> get latestMovies => _latestMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;
  bool get isLoading => _isLoading;

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _movieService.searchMovies(query);
    } catch (e) {
      _movies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> initMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([
        fetchLatestMovies(),
        fetchPopularMovies(),
        fetchTopRatedMovies(),
        fetchUpcomingMovies(),
      ]);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchLatestMovies() async {
    _latestMovies = await _movieService.fetchLatestMovies();
    notifyListeners();
  }

  Future<void> fetchPopularMovies() async {
    _popularMovies = await _movieService.fetchPopularMovies();
    notifyListeners();
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMovies = await _movieService.fetchTopRatedMovies();
    notifyListeners();
  }

  Future<void> fetchUpcomingMovies() async {
    _upcomingMovies = await _movieService.fetchUpcomingMovies();
    notifyListeners();
  }

  void toggleFavorite(Movie movie) {
    final allMovies = [..._movies, ..._latestMovies, ..._popularMovies, ..._topRatedMovies, ..._upcomingMovies];
    for (var m in allMovies) {
      if (m.title == movie.title) {
        m.isFavorite = !m.isFavorite;
      }
    }
    notifyListeners();
  }

}
