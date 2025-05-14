import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String _apiKey = '7208209b29348ce14977d8eccd0bc17c';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/search/movie?api_key=$_apiKey&query=$query'));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchLatestMovies() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/now_playing?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch latest movies');
    }
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/popular?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse(
      '$_baseUrl/movie/top_rated?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch top rated movies');
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/upcoming?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch upcoming movies');
    }
  }
}